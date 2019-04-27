# C Sharp Basics

C# is very complex language and there are a lot of concepts to learn. This guide is not ment to teach you the whole breadth of C# concepts, but just the concepts I ran into in my first 24 hours of scripting in Sansar.

|#|Table of Contents|
|-|-|
|1|[Objects](#objects)|
|2|[Classes](#classes)|
|3|[Inheritance and Interfaces](#Inheritance-and-Interfaces)|
|4|[Method Arguments and Constructors](#Method-Arguments-and-Constructors)|
|5|[Generic Types](#Generic-Types)|
|6|[Attributes](#Attributes)|
|7|[Scope and Inline Functions](#Scope-and-Inline-Functions)|
|8|[Logic Gates and Operators](#Logic-Gates-and-Operators)|
|9|[Namespaces and Using](#Namespaces-and-Using)|

## Objects

C# is an object-oriented programing language (OOP), which means it treats everything as an "object". An object is basically some value, or `state`, that is wrapped with a bunch of helper functions, or `methods`, that do something with this state. An object's methods have to be defined in advance in `classes`, which are a sort of blueprint to the value and what it can do. What class an object is made of is known as it's `type`. A `string` is a type, so is `float`, `int` or any other class name available in your current environment.

So, if I have a piece of text, or `string`, and want to make it all upper case, I can write something like:

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

So here we can see that we stored our value in a variable, turned it to upper case with it's `ToUpper()` method and used it inside `Log.Write()`. This should print in console: 

```
HELLO WORLD
```

## Classes

Types like `string` and `int` are primitive types, which behave a little different from regular classes, which we wont get into now. But the main difference is you _create_ a `string` by wrapping it in quotes, or just write the number for `int`, but for any none primitive class you create it using the `new` keyword:

```csharp
MyClass someObject = new MyClass();
```

And you define a custom class like so:

```csharp
public class MyClass 
{

  string MyMessage = "Hello World";

  public string GetMessage() 
  {
    return MyMessage;
  }

}
```

In the above example, we defined a string variable with the text `Hello World` inside our class, and a method `GetMessage()` which `returns` the variable. Returning a value basically means you pass on a value to be used outside this method when it is called, just like `ToUpper()` returned a string with all upper case. The `string` before `GetMessage()` says this method returns a string value, which means you have to return a string at some point inside your method, in our case it is the first line in the method. If the method does not return any value, then you can replace `string` with `void`. The `public` keyword means this method is accessible outside the internals of the class, ie for public access. Normally if you do not want to expose internal helper functions and variables then you can omit the public keyword.

The above example can then be used like so:

```csharp
MyClass someObject = new MyClass();

Log.Write(someObject.GetMessage());
```

And for the complete code that is usable in Sansar:

```csharp
using Sansar.Simulation;

public class MyClass 
{

  string MyMessage = "Hello World";

  public string GetMessage() 
  {
    return MyMessage;
  }

}

public class HelloWorld : SceneObjectScript 
{

  public override void Init() 
  {
    MyClass someObject = new MyClass();

    Log.Write(someObject.GetMessage());
  }
  
}
```

## Inheritance and Interfaces

A core concept of OOP is the notion of inheritance, meaning a cetain class can "inherit" the properties and methods of another class by `extend`ing it. Extending a class allows for having different variations of the same core type. A common example used in teaching inheritance is with the animal kingdom, where you have a parent class called `Animal`, and then you would have other child classes extending it such as `Mammal` or `Reptile`, and then go down even further in the hierarchy where `Canine` or `Feline` extend `Mammal`. In the context of Sansar and scripting games, you could make a class `Npc`, and then extend that into `FriendlyNpc` and `EnemyNpc`. The benfit in this example, is that an NPC may have methods and properties that are common in both enemy and friendly npc, such as `Name` or `SayInChat()`, but enemy NPC may have a method for `Attack()` while the friendly NPC does not. This concept saves you from having to copy paste functionality between classes and generally makes for much cleaner and easier to maintain code.

So implementing our NPC example above would look something like this:

```csharp
public abstract class Npc 
{
  public string Name;

  public void SayInChat(string message) 
  {
    // Say in chat code
  }
}

public class EnemeyNpc : Npc 
{
  public void Attack()
  {
    // Attack code
  }
}

public class FriendlyNpc : Npc
{
  public void AskForQuest() {
    // Ask for quest code
  }
}
```

The `abstract` keyword in the code above means this class cannot be made into an object on its own, and that only its child classes can.

Then you could use the above classes like so:

```csharp
EnemeyNpc zombie = new EnemyNpc();
zombie.Name = "Jane the neighbor"

FriendlyNpc randomSurvivor = new FriendlyNpc();
randomSurvivor.Name = "Mary the doctor";

zombie.SayInChat("hhmmhhm....");
zombie.Attack();
randomSuvivor.SayInChat("Runnnn!");
```

### Interfaces

`Interface`s can also be added to classes, and are used to define available methods that are common between several unrelated classes. This allows to have a common "interface" on objects that you may not care about their underlying classes. So continuing our example above, a possible interface we could have is `CanSpeak` that expects the class to have `SayInChat()` method. So a possible example of this is:

```csharp
interface CanSpeak; 
{
  void SayInChat(string message);
}

public abstract class Npc : CanSpeak
{
  public string Name;

  public void SayInChat(string message) 
  {
    // Say in chat code
  }
}

public class FriendlyNpc : Npc
{
  public void AskForQuest() {
    // Ask for quest code
  }
}

public class SpeakerPhone : CanSpeak {

  public void SayInChat(string message) 
  {
    // Say in chat code
  }

}
```

Notice that `FriendlyNpc` ineherited the `CanSpeak` interface from `Npc`. Then you could use it like so:

```csharp
CanSpeak announcer = new SpeakerPhone();
announcer.SayInChat("Welcome");
announcer = new FriendlyNpc();
announcer.SayInChat("Who said that?");
```

## Method Arguments and Constructors

Properties are variables inside the class, and methods are functions inside the class. You could think of methods as being "verbs" that an object can do. Though methods become alot more useful when you give them parameters, or `arguments`, to use in what you want the object to do. For example, in the context of game making, you may have a "health" property which tracks the player's hitpoints, and you may have a `WasHit()` method that affects the health, but it would be more useful if you could say how much damage to apply, so you could add damage amount as an argument like `WasHit(int damage)`. Then you could use this argument like any other variable inside the method. So an example of this would be:

```csharp
class Player 
{

  int HitPoints = 100;

  public void WasHit(int damage) 
  {
    Hitpoints = Hitpoints - damage;
  }

}
```

This can be extended to add more arguments such as adding a "distance" argument that will not apply the damage if the hitter was too far away, and return `true` on succeful hit, and false if not:

```csharp
class Player 
{

  int HitPoints = 100;

  public bool WasHit(int damage, float distance) 
  {
    if (distance > 30) 
    {
      return false;
    }

    Hitpoints = Hitpoints - damage;
    return true;
  }

}
```

### Constructors

`Constructor`s are a special kind of method in a class that will be called when the object is created with `new`. They need to be named with the same name of the class. Constructors are normally used to defined the initial values of the object. For example:

```csharp
class Player { 

  int Hitpoints;

  public Player(int initialHitpoints) 
  {
    Hitpoints = initialHitpoints;
  }

  public bool WasHit(int damage, float distance) 
  {
    if (distance > 30) 
    {
      return false;
    }

    Hitpoints = Hitpoints - damage;
    return true;
  }

}
```

Which then can be used like so: 

```csharp
Player player1 = new Player(100);
```

### Out Arguments

Another type of argument you will run into in Sansar api often is `out` arguments, which are not input parameters, but just variables that need to be set inside the method which then can be used outside the method. This is handy if you need the `return` value for something else but need additional output values to get from the method. For example:

```csharp
class Player 
{

  int Hitpoints;

  public Player(int initialHitpoints) 
  {
    Hitpoints = initialHitpoints;
  }

  public bool WasHit(int damage, float distance, out bool isDead) 
  {
    if (disatnce > 30) 
    {
      isDead = false;
      return false;
    }

    Hitpoints = Hitpoints - damage;

    if (HitPoints <= 0) 
    {
      isDead = true;
    }
    return true;
  }

}
```

In the example above I added more logic to `WasHit()` that will also set the `isDead` variable to true if the player has less than (or equal to) 0 hitpoints. This can then be used like so:

```csharp
Player player1 = new Player(100);

bool isKill;
player1.WasHit(40, 20, out isKill); // damage 50, isKill is false
player1.WasHit(50, 40, out isKill); /// too far away, no damage, isKill is false
player1.wasHit(70, 4, out isKill); // damage 70, isKill is true

if (isKill)
{
  // player was killed code
}

```

## Generic Types

Classes can be defined with additional types as arguments, generally when you have a "type of types". For example, a `List` type has to be declared with another type, such as `List<string>`, which is a "list of strings", or `Dictionary<string, int>` (dictionary is key/value map) which means a "map of strings to ints". Creating your own generic classes is a bit advanced so I will not cover that here.

Methods can also accept types, such as `AsInterface()` in `Reflective` classes, such as:

```csharp
SubscribeToAll(MyEvent, (ScriptEventData data) => 
{
  ISimpleData sd = data.Data?.AsInterface<ISimpleData>();
});

```

## Attributes

Attributes are meta properties that generally do not need to excute during runtime, and is added on top of propeties, methods, and classes. This is mostly needed in Sansar scripts when defining scripts and their parameters, which you can learn about [here](sansar-scripts.md).

An attribute is encapsulated in square brackets and looks something like this:

```csharp
[DefaultScript]
[DisplayName("My Script")]
public class MyScript : SceneObjectScript {

  public override void Init() 
  {

  }

}
```

## Scope and Inline Functions

## Logic Gates and Operators

## Namespaces and Using