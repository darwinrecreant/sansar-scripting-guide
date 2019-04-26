# C Sharp Basics

## Objects

C# is and object-oriented programing language (OOP), which means it treats everything as an "object". An object is basically some value, or `state`, that is wrapped with a bunch of helper functions, or `methods`, that do something with this state. An object's methods have to be defined in advance in `classes`, which are a sort of blueprint to the value and what it can do. What class an object is made of is known as it's `type`. A `string` is a type, so is `float`, `int` or any other class name available in your current environment.

So, if I have a piece pf text, or `string`, and want to make it all upper case, you can write something like:

```csharp
"Hello World".ToUpper();
```

On it's own, this line does not do anything, because it is turning the text to upper case but does nothing with it. To make it do something useful we should store the value in a `variable` so we can use it repeatedly through out our code.

```csharp
string MyText = "Hello World";
```

This code still does not do anything, we have to use it somehow. The fastest way to get an output in a script is using `Log` (note: `Log` is a Sansar specific object and will not be found in other C# environments):

```csharp
string MyText = "Hello World";

Log.Write(MyText.ToUpper());
```

So here we can see that we stored our value in a variable, turned it to upper with it's `ToUpper()` method and used it inside `Log.Write()`. This should print in console: 

```
HELLO WORLD
```

# Classes

Types like `string` and `int` are primitive types, which behave a little different from regular classes, which we wont get into now. But the main difference is you _create_ a `string` by wrapping it in quotes, or for just write the number for `int`, but for every other class you create it using the `new` keyword:

```csharp
MyClass someObject = new MyClass();
```

And you defined a custom class like so:

```csharp
pulbic class MyClass {

  string MyMessage = "Hello World";

  string GetMessage() {
    return MyMessage;
  }

}
```

In the above example, we defined a string variable with the text `Hello World` inside our class, and a method `GetMessage()` which `returns` the variable. Returning a value basically means you pass on a value to be used outside this method when it is called. The `string` before `GetMessage()` says this method returns a string value, which means you have to return a string at some point in your method, in our case it is the first line in the method. If the method does not return any value, then you can replace `string` with `void`.

The above examble can then be used like so:

```csharp
MyClass someObject = new MyClass();

Log.Write(someObject.GetMessage());
```

And for the complete code that is usable in Sansar:

```csharp
using Sansar.Simulation;

public class MyClass {

  string MyMessage = "Hello World";

  string GetMessage() {
    return MyMessage;
  }

}

public class HelloWorld : SceneObjectScript {

  public override void Init() {
    MyClass someObject = new MyClass();

    Log.Write(someObject.GetMessage());
  }
  
}
```
