# Creating Script Library Compatible Scripts

Script Library scripts (formerly known as Simple Scripts) are a set of scripts provided with every Sansar installation that define a common communication protocol between scripts, and provides some starter scripts for interaction with objects in-world.

The library comes bundled with `LibraryBase.cs` which allows to use the Library's communication protocol in your own scripts.

## Project Structure

To include the `LibraryBase.cs` in your project you will need to make your project uploadable with a sources `json` file. If you are using this repository as your workspace and followed the [IDE setup guidelines](vscode.md), then your sources file would look something like this:

**HelloWorld.json**
```javascript
{
  "source": [
    "HellowWorld.cs",
    "../ScriptLibrary/LibraryBase.cs",
  ]
}
```

While having project structure like this:

```
workspace/
- HelloWorld/
-- HelloWorld.cs
-- HelloWorld.json
- ScriptLibrary/
-- LibraryBase.cs
-- ...
```

## Script Contents

To make the script compatible with the Script Library, simply extend `SceneObjectBase` instead of `SceneObjectScript` and use `SimpleInit()` instead of `Init()` as your script bootstrap method. The bare mininum to create the script is as follows:

```csharp
using ScriptLibrary;

public class HelloWorld : SceneObjectBase 
{

  protected override void SimpleInit() 
  {
    Log.Write("Hello World");
  }

}
```

However, this does not use the library's event system yet so there is nothing special here.

## Using Events

`LibraryBase.cs` does alot of event processing as well as handle the protocol's event naming scheme, and using it will allow your users to set event targets in script parameters like they do in other Script Library scripts.

There are two main functions to handle these events:
- `SubscribeToAll()` - This will subscribe to event targets from parameters
- `SendToAll()` - This will broadcast event targets

It would be good practice to also include enable/disable events as do all Script Library scripts do.

Following these guidelines, you can then have the following template to start creating these scripts:

```csharp
using System;
using Sansar.Script;
using ScriptLibrary;

namespace Templates 
{

  public class ScriptLibraryTemplate : SceneObjectBase 
  {

    [Tooltip("Enable responding to events for this script")]
    [DefaultValue("_enable")]
    [DisplayName("-> Enable")]
    public readonly string EnableEvent;

    [Tooltip("Disable responding to events for this script")]
    [DefaultValue("_disable")]
    [DisplayName("-> Disable")]
    public readonly string DisableEvent;

    [Tooltip(@"If StartEnabled is true then the script will respond to interactions when the scene is loaded
If StartEnabled is false then the script will not respond to interactions until an (-> Enable) event is received.")]
    [DefaultValue(true)]
    [DisplayName("Start Enabled")]
    public readonly bool StartEnabled = true;

    Action subscription = null;

    protected override void SimpleInit() 
    {
      if (StartEnabled) Subscribe(null);

      SubscribeToAll(EnableEvent, Subscribe);
      SubscribeToAll(DisableEvent, Unsubscribe);
    }

    void Subscribe(ScriptEventData sed) 
    {
      // if (!string.IsNullOrWhiteSpace(MyCustomEvent)) 
      // {
      //   subscription += SubscribeToAll(MyCustomEvent, (ScriptEventData data) => 
      //   {
      //     ISimpleData sd = data.Data.AsInterface<ISimpleData>();
      //     if (sd == null) return;
      //
      //   });
      // }
    }
    void Unsubscribe(ScriptEventData sed) 
    {
      if (subscription != null) 
      {
        subscription();
        subscription = null;
      }
    }
  }
}
```