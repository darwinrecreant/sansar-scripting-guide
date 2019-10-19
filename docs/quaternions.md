# Quaternions Cheatsheet

Quaternions are a representation of rotation _change_ in 3d evironments. Rotation change means that it could represent more than a full 360 degree rotation or even a 0 rotation change. The constant of zero rotation is `Quaternion.Identity`.

Quaternions are represented by 4 values (`X`, `Y`, `Z`, and `W`). Creating quaternions requires deep understanding behind rotation math so setting these values manually is not advised unless you know exactly what you are doing. Thankfully we can create quaternions through several other methods.

## Rotating Vectors

A vector can be rotated around the zero point origin (which is the same as `Vector.Zero`). Vectors can represent a a direction, or an offset from a certain position, this is where it is valid to rotate with a quaternion. If the vector was a global position in the scene then rotating it does not make much sense, because the zero point origin has no meaningful purpose in that context.

A `Vector` can be rotated like so:

```csharp
Vector RotateVector(Vector offsetOrDirection, Quaternion rotation) {
  return offsetOrDirection.Rotate(rotation);
}
```

There is a constant for each Vector global direction that can be used:
- `Vector.ObjectForward` - <0,1,0>
- `Vector.ObjectBack` - <0,-1,0>
- `Vector.ObjectRight` - <1,0,0>
- `Vector.ObjectLeft` - <-1,0,0>
- `Vector.ObjectUp` - <0,0,1>
- `Vector.ObjectDown` - <0,0,-1>

## Creating quaternions from angles

### From euler angles

Euler angles are radian (as opposed to 360 degrees) based angles. There are 2 * PI radians in 360 degrees. A rotation can be represented by 3 radian values, or a `Vector` of `X`, `Y`, and `Z`, where each value is a rotation around the respective axis. Not all Euler vectors are valid, because of [gimble-locking](https://www.youtube.com/watch?v=zc8b2Jo7mno). All rotation parameters in the Sansar UI are in Euler degree vectors, which are considered to be more human-friendly representation of rotations. Converting a Euler degree vector to a radian vector can be done like so:

```csharp
Vector ConvertToRadian(Vector degreeBased) {
  return degreeBased / 180.0f * (float)Math.PI;
}
```

Creating a quaternion from a radian Euler vector can be done like so:

```csharp
Quaternion ConvertoToQuaternion(Vector radianBasedAngles) {
  return Quaternion.FromEualerAngles(radianBasedAngles);
}
```

### From angle and axis

A quaternion can be created from an radian angle and an axis like so:

```csharp
Quaternion ConvertionToQuaternion(float angle, Vector axis) {
  return Quaternion.FromAngleAxis(angle, axis);
}
```

An axis here is a direction in the form of a vector, which is a point relative to the zero point origin.

Creating simple rotation of 90 degrees around the z axis can be done like so:

```csharp
Quaternion RotateZ(float angleDegrees) {
  return Quaternion.FromAngleAxis(angleDegrees / 180.0f * (float)Math.PI, Vector.ObjectUp);
}
```

### From "Look"

One of my favorite ways to create rotations is using `Quaternion.FromLook`. This method accepts a vector forward direction and a vector up direction, which together can form a meaningful rotation. It is used like so:

```csharp
Quaternion ConvertToQuaternion(Vector forward, Vector up) {
  return Quaternion.FromLook(forward, up);
}
```

This is useful because you can get the rotation of a follower so that they face the agent by using the positon offset between the two. The neat part is you can make the rotation stay horizontal by setting the Z of the position offset to zero, such as when an npc is walking uphill where you do not want the npc to rotate in the direction of the hill, but remain upwards:

```csharp
Quaternion RotationFacingAgent(ObjecPrivate obj, ObjectPrivate agent, bool keepHorizontal) {
  Vector offset = agent.Position - obj.Position;
  if (keepHorizontal) {
    offset.Z = 0;
  }
  return Quternion.FromLook(offset, Vector.Up);
}
```

Using `FromLook` can also be used to get the rotation at the ground slope, such as when using a raycast which gives us the `Normal` of the hit, which is the vector direction perpendicular to the hit position, and allow to position the object as if it was laying on the ground, in the correct orientation. The following code utilizes `FromLook` on a Normal using a rotation constant that fixes the result orientation:

```csharp
Quaternion LookAtAngleFix = Quaternion.FromEulerAngles(new Vector(1, 1, 0) * (float)Math.PI / 2);

Quaternion RotationAtGround(RayCastHit ground, Vector forward) {
  return (Quaternion.FromLook(ground.Normal, forward) * LookAtAngleFix).Normalized();
}
```

## Quaternion operations

Applying one rotation to another is done through the muliply (`*`) operator. Rotating a rotation can be somewhat confusing and unintuitive, especially because the order if opertation matters here unlike regular math multiplication. At every step you have to think, what is the starting rotation, and how do I want to transform it. 

Another way to explain rotation multiplication is global vs local. Suppose you have a 90 degree rotation quaternion on the z axis (Rz), and you have an object's rotation (Ro). Ro * Rz would result in the object rotating local to the object's rotation wherever it is facing, like someone holding a fidget spinner. While Rz * Ro would make the object rotate on the global Z axis, as if it was standing on a rotating platform.

Also whenever multiplying rotations, it is advised to `Normalize` often, which turns the quaternion to unit values, to avoid floating point errors.

```csharp
Quaternion RotateAnObject(ObjectPrivate obj, Quaternion rot) {
  return (obj.Rotation * rot).Normalized();
}

Quaternion UndoRotation(ObjectPrivate obj, Quaternion rot) {
  return (obj.Rotation * rot.Inverse()).Normalized();
}
```

Many times the forward facing direction of an object is different from the rotation as it appears in scene edit, this is because different modeling software define different forward/up axes, and this requires adding rotation corrections. The following example will get the forward direction of an object, given a desired global rotation and an object's correction rotation.

```csharp
Vector GetMyObjectForward(ObjectPrivate obj, Quaternion correction) {
  return obj.ForwardVector.Rotate(correction.Inverse());
}
Vector SetRealObjectForward(Quaternion correction) {
  return Vector.ObjectForward.Rotate(correction);
}

Quaternion GetMyObjectRotation(ObjectPrivate obj, Quaternion correction) {
  return (obj.Rotation * correction.Inverse()).Normalized();
}

Quaternion SetRealObjectRotation(Quaternion myRot, Quaternion correction) {
  return (myRot * correction).Normalized();
}
```

Which then can be used on a moving npc like so:

```csharp
Vector StepFacingForward(float stepSize, ObjectPrivate npc, Quaternion correction) {
  return npc.Position + GetMyObjectForward(npc, correction) * stepSize;
}
```

### Quaternion steps

Sometimes you want to find a fraction of a rotation between two rotations, such as when trying to animate a rotation. This can be done by interpolating the rotation with the `Slerp` operation on the quaternion. Unforturnately this function is not available to us through the Script API. I have included an implementation of Slerp at the bottom of this document, which will add an extension to `Quaternion`.

Once you included the extension method, it is then possible to find the fraction of rotation between two rotations, which would be used like so:

```csharp
Quaternion RotationStep(Quaternion from, Quaternion to, float stepFraction) {
  return from.Slerp(to, stepFraction);
}
```

**Slerp.cs**

```csharp
  public static class QuaternionExt {
    /// <summary>
    /// Smoothly interpolate between the two given quaternions using Spherical 
    /// Linear Interpolation (SLERP).
    /// </summary>
    /// <param name="from">First quaternion for interpolation.</param>
    /// <param name="to">Second quaternion for interpolation.</param>
    /// <param name="t">Interpolation coefficient.</param>
    /// <returns>SLERP-interpolated quaternion between the two given quaternions.</returns>
    public static Quaternion Slerp(this Quaternion from, Quaternion to, double t)
    {
      return from.Slerp(to, t, true);
    }
    /// <summary>
    /// Smoothly interpolate between the two given quaternions using Spherical
    /// Linear Interpolation (SLERP).
    /// </summary> 
    /// <param name="from">First quaternion for interpolation.
    /// <param name="to">Second quaternion for interpolation. 
    /// <param name="t">Interpolation coefficient. 
    /// <param name="useShortestPath">If true, Slerp will automatically flip the sign of
    ///   the destination Quaternion to ensure the shortest path is taken. 
    /// <returns>SLERP-interpolated quaternion between the two given quaternions.</returns>
    public static Quaternion Slerp(this Quaternion from, Quaternion to, float t, bool useShortestPath)
    {
      if (from.Equals(Quaternion.Identity)) 
      {
        from.W = 1; 
      } 
      if (to.Equals(Quaternion.Identity))
      { 
        to.W = 1;
      }
 
      double cosOmega; 
      float scaleFrom, scaleTo;
  
      // Normalize inputs and stash their lengths 
      float lengthFrom = from.Length();
      float lengthTo = to.Length(); 
      from = from.Scale(1/lengthFrom);
      to = to.Scale(1/lengthTo);
 
      // Calculate cos of omega. 
      cosOmega = from.X*to.X + from.Y*to.Y + from.Z*to.Z + from.W*to.W;
  
      if (useShortestPath) 
      {
        // If we are taking the shortest path we flip the signs to ensure that 
        // cosOmega will be positive.
        if (cosOmega < 0.0)
        {
          cosOmega = -cosOmega; 
          to.X = -to.X;
          to.Y = -to.Y; 
          to.Z = -to.Z; 
          to.W = -to.W;
        } 
      }
      else
      {
        // If we are not taking the UseShortestPath we clamp cosOmega to 
        // -1 to stay in the domain of Math.Acos below.
        if (cosOmega < -1.0) 
        { 
          cosOmega = -1.0;
        } 
      }
 
      // Clamp cosOmega to [-1,1] to stay in the domain of Math.Acos below.
      // The logic above has either flipped the sign of cosOmega to ensure it 
      // is positive or clamped to -1 aready.  We only need to worry about the
      // upper limit here. 
      if (cosOmega > 1.0) 
      {
        cosOmega = 1.0; 
      }
 
      // The mainline algorithm doesn't work for extreme 
      // cosine values.  For large cosine we have a better 
      // fallback hence the asymmetric limits.
      const double maxCosine = 1.0 - 1e-6; 
      const double minCosine = 1e-10 - 1.0;
 
      // Calculate scaling coefficients.
      if (cosOmega > maxCosine) 
      {
        // Quaternions are too close - use linear interpolation. 
        scaleFrom = 1.0f - t; 
        scaleTo = t;
      } 
      else if (cosOmega < minCosine)
      {
        // Quaternions are nearly opposite, so we will pretend to
        // is exactly -from. 
        // First assign arbitrary perpendicular to "to".
        to = new Quaternion(-from.Y, from.X, -from.W, from.Z); 
  
        double theta = t * Math.PI;
  
        scaleFrom = (float)Math.Cos(theta);
        scaleTo = (float)Math.Sin(theta);
      }
      else
      {
        // Standard case - use SLERP interpolation. 
        double omega = Math.Acos(cosOmega); 
        double sinOmega = Math.Sqrt(1.0 - cosOmega*cosOmega);
        scaleFrom = (float)(Math.Sin((1.0 - t) * omega) / sinOmega); 
        scaleTo = (float)(Math.Sin(t * omega) / sinOmega);
      }
 
      // We want the magnitude of the output quaternion to be 
      // multiplicatively interpolated between the input
      // magnitudes, i.e. lengthOut = lengthFrom * (lengthTo/lengthFrom)^t 
      //              = lengthFrom ^ (1-t) * lengthTo ^ t 
 
      float lengthOut = lengthFrom * (float)Math.Pow(lengthTo/lengthFrom, t); 
      scaleFrom *= lengthOut;
      scaleTo *= lengthOut;
 
      return new Quaternion(scaleFrom*from.X + scaleTo*to.X, 
                  scaleFrom*from.Y + scaleTo*to.Y,
                  scaleFrom*from.Z + scaleTo*to.Z, 
                  scaleFrom*from.W + scaleTo*to.W); 
    }
  
    /// <summary> 
    /// Scale this quaternion by a scalar.
    /// </summary> 
    /// <param name="scale">Value to scale by.
    public static Quaternion Scale(this Quaternion quat, float scale )
    {
      if (quat.Equals(Quaternion.Identity)) 
      {
        quat.W = scale;  
        return quat;
      } 
      quat.X *= scale;
      quat.Y *= scale;
      quat.Z *= scale;
      quat.W *= scale; 
      return quat;
    }
  }
```