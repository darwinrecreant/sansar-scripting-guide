# Sansar Scripting Guide

This is a guide for C# scripting in Sansar, and serves as a temporary repository of tips and hints for api until we have an official wiki to use.

1. [Intro to C#](#intro-to-c)
2. [Intro to Sansar Scripts](#intro-to-sansar-scripts)
3. [Sansar Controls](#sansar-controls)


## Intro to C#

C# (C Sharp) is an object-oriented programming (OOP) language developed by Microsoft that is primarily used for creating games. Many popular gaming frameworks, such as Unity, use C#, and this is also the language used for Sansar scripts.

- [Setting up Visual Studio Code](/docs/vscode.md)
- [C# Basics](/docs/c-sharp.md)

## Intro to Sansar Scripts

Sansar scripts use a custom subset of C# that restict the usage to only whitelisted native libraries, for both security and performance reasons. Normally, if a native library is too useful but fails either these two requirements, than a custom implenetation will be provided with some limitations applied; `HttpClient` is a prime example of this.

- [Getting started with Sansar scripts](/docs/sansar-scripts.md)
- [Creating Simple Scripts](/docs/simple-scripts.md)

## Sansar Controls

User controls can be subscribed to using `User.Client.Subscribe()`. Currently there is no way to block Sansar native controls when listening to them.

| Keyword | Desktop | Vive | Rift | Notes |
|---------|:-------:|:----:|:----:|-------|
| `Trigger` | mouse <kbd>click</kbd> | <kbd>trigger</kbd> | <kbd>trigger</kbd> | Used as the "fire" control. |
| `PrimaryAction` | <kbd>F</kbd> | <kbd>grip</kbd> | <kbd>grip</kbd> | Used for picking up / dropping things. If the object has the "Stick to hand" flag turned off, then mouse click will also drop the item on desktop.|
| `SecondaryAction` | <kbd>R</kbd> | center <kbd>click</kbd> | <kbd>A</kbd> / <kbd>X</kbd> | Normally used as the "gun reload" control|
| `Confirm` | <kbd>Enter</kbd> | | <kbd>B</kbd> | |
| `Cancel` | <kbd>Esc</kbd> | | <kbd>Y</kbd> | |
| `Modifier`| <kbd>Shift</kbd> | | | Used for toggling running on/off |
| `SelectUp` | <kbd>&#x2191;</kbd> | | | |
| `SelectDown` | <kbd>&#x2193;</kbd> | | | |
| `SelectRight` | <kbd>&#x2192;</kbd> | | | |
| `SelectLeft` | <kbd>&#x2190;</kbd> | | | |
| `KeypadEnter` | Keypad <kbd>Enter</kbd> | | | |
| `Keypad[0-9]` | Keypad <kbd>0</kbd>  - <kbd>9</kbd> | | | For example `Keypad5` is triggered when <kbd>5</kbd> is pressed in the keypad area of the keyboard|
| `Action[0-9]` | <kbd>0</kbd> - <kbd>9</kbd> | | | For example `Action3` is triggered when <kbd>3</kbd> is pressed in the numbers area of the keyboard|
