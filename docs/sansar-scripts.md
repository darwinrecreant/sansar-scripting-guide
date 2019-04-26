# Getting Started with Sansar Scripts

Before starting to write scripts, it is best if you s[etup your development environment](vscode.md), it will make your life alot easier.

## Script Structure

The bare minimum in a Sansar script is the following:

```csharp
using Sansar.Simulation;

public class HelloWorld : SceneObjectScript {

  public override void Init() {
    Log.Write("Hello World");
  }
  
}
```

The main class of a script must extend `SceneObjectScript` and include an `Init()` function. Init is where the script bootstraps when the scene instance is first started, or when the object with the script is first rezzed.

## Mutli-part Scripts

Sansar scripts can include several scene classes in one script, which would result in a dropdown choice when inserting the script in-world. Therefore, you can have more than one `SceneObjectScript` in your script, then you should include a `[DefaultScript]` attribute above one of your classes to make that the default script in your collection, like so:

```csharp
using Sansar.Simulation;
using Sansar.Script;

[DefaultScript]
public class HelloWorld : SceneObjectScript {

  public override void Init() {
    Log.Write("Hello World");
  }
  
}

public class HelloWorld2 : SceneObjectScript {

  public override void Init() {
    Log.Write("Hello World2");
  }
  
}
```

## Multi-file Scripts

You can split your script project into multiple files. This can be uploaded to Sansar as a `json` file that includes the paths of your C# files. Paths can be either relative or absolute. The structure of the json should be something like this:

```javascript
{
  "source": [
    "HellowWorld.cs",
    "HellowWorld2.cs",
  ]
}
```

This is especially handy for orginizating large projects, or including scripts between projects, or more commonly including the `LibraryBase.cs` provided by Sansar for creating [Script Library](simple-scripts.md) compatible scripts (aka Simple Scripts).

## Script Parameters

Scripts can have parameters that are exposed in the scene editor when attaching the scripting to an object, which basically allows for adding user configuration to scripts before the script executes in the experience.

Parameters are basically public variables on the main `SceneObjectScript` class, that must follow a few requirements. An example usage of a parameter is as follows:

```csharp
using Sansar.Simulation;
using Sansar.Script;

public class HelloWorld : SceneObjectScript {

  [DisplayName("My Message")]
  [DefaultValue("Hello World")]
  public string Message;

  public override void Init() {
    Log.Write(Message);
  }
  
}
```

The requirements for a valid parameters are:
- The variable must be public
- The variable must be one of the primitive types (`string`, `int`, `bool`, `float`, `Vector`, `Quaternion`), a resource type like `SoundResource` which would just result in an inventory picker, or a List of one of the allowed types, such as `List<string>`, which would result in a multi value input.

## Debugging

When visiting an experience, it is possible to see the debug console by pressing `Ctrl + D` which is visible only to the scene owner. Any errors, warnings, or notices will be visible in this console.

You can write your own console messages using `Log.Write()`. For example:

```csharp
using Sansar.Simulation;
using Sansar.Script;

public class HelloWorld : SceneObjectScript {

  public override void Init() {
    Log.Write("Log message");
    Log.Write(LogLevel.Warning, "Log warning");
    Log.Write(LogLevel.Error, "Log error");
  }
  
}
```

It is best practice to write your debug messages in console instead of print in chat.