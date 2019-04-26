# C Sharp Basics

## Objects

C# is and object-oriented programing language (OOP), which means it treats everything as an "object". An object is basically some value, or `state`, that is wrapped with a bunch of helper functions, or `methods`, that do something with this state. An object's methods have to be defined in advanced in `classes`, which are a sort of blueprint to the value and what it can do. What class an object is made of is knowm as it's `type`. A `string` is a type, so is `float`, `int` or any other class name available in your current environment.

For example, if I have a piece pf text, or `string`, and want to make it all upper case. I can write something like:

```csharp
"Hello World".ToUpper();
```

On it's own, this line does not do anything, because it is turning the text to upper case but does nothing with it. To make useful we should store the value in a `variable` so we can use it repeatedly through out our code.

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