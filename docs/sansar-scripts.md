# Getting Started with Sansar Scripts

## Script Structure

The bare minimum in a Sansar sctipt is the following:

```csharp
using Sansar.Simulation;

public class HelloWorld : SceneObjectScript {

  public override void Init() {
    Log.Write("Hello World");
  }
  
}
```

The main class of a script must extend `SceneObjectScript` and include an `Init()` funciton. Init is where the script bootstraps when the scene instance is first created.

## Mutli-part Scripts

Sansar scripts can include several scene classes in one script, which would result in a dropdown choice when inserting the script in-world. Therefore, you can have more than one `SceneObjectScript` in your script, then you should include a `[DefaultScript]` attribute above one of your classes to make that the default script in your collection, like so:

```csharp
using Sansar.Simulation;

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

This is especially handy for orginizating large projects, or including scripts between projects, or more commonly including the `LibraryBase.cs` provided by Sansar for creating [Script Library (aka simple scripts)](simple-scripts.md) compatible scripts.

## Script Parameters

Scripts can have parameters that are exposed in the scene editor when attaching the scripting to an object, which basically allows for adding user configuration to scripts before the script is excuted in the experience.