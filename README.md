# Sansar Scripting Guide

This is a guide for C# scripting in Sansar, and serves as a temporary repository of tips and hints for api until we have an official wiki to use.

1. [Intro to C#](#intro-to-c#)
2. [Intro to Sansar Scripts](#intro-to-sansar-scripts)
3. [Sansar Controls](#sansar-controls)


## Intro to C#

C# (C Sharp) is an object-oriented programming (OOP) language developed by Microsoft that is primarily used for creating games. Many popular gaming frameworks, such as Unity, use C#, and this is also the lanugage used for Sansar scripts.

- [Getting started with C#](/docs/c-sharp.md)

## Intro to Sansar Scripts

Sansar scripts use a custom subset of C# that restict the usage to only whitelisted native libraries, for both security and performance reasons. Normally if native a library is too useful but fails either these two requirements, than a custom implenetation will be provided with some limitations applied; `HttpClient` is a prime example of this.

- [Getting started with Sansar scripts](/docs/sansar-scripts.md)

## Sansar Controls

User controls can be subscribed to using `User.Client.Subscribe()`. Currently there is no way to block Sansar native controls when listening to them.

| Keyword | Desktop | Vive | Rift | Notes |
|---------|:-------:|:----:|:----:|-------|
| `Trigger` | mouse click | trigger | trigger | Used as the "fire" control. |
| `PrimaryAction` | F | grip | grip | Used for picking up / dropping things. If the object has the "Stick to hand" flag turned off, then mouse click will also drop the item on desktop.|
| `SecondaryAction` | R | center click | A/X | Normally used as the "gun reload" control|
| `Confirm` | Enter | | B | |
| `Cancel` | Esc | | Y | |
| `Modifier`| Shift | | | Used for toggling running on/off |
| `SelectUp` | &#x2191; | | | |
| `SelectDown` | &#x2193; | | | |
| `SelectRight` | &#x2192; | | | |
| `SelectLeft` | &#x2190; | | | |
| `KeypadEnter` | Keypad Enter | | | |
| `Keypad[0-9]` | Keypad 0 - 9 | | | For example `Keypad5` is triggered when `5` is pressed in the keypad area of the keyboard|
| `Action[0-9]` | 0 - 9 | | | For example `Action3` is triggered when `3` is pressed in the numbers area of the keyboard|
