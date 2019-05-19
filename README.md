# Sansar Scripting Guide

This is a guide for C# scripting in Sansar, and serves as a temporary repository of tips and hints for scripting until we have an official wiki to use.

|#|Section|
|-:|-|
|1|[Intro to C#](#intro-to-c)|
|2|[Intro to Sansar Scripts](#intro-to-sansar-scripts)|
|3|[Limits](#limits)|
|4|[Sansar Controls](#sansar-controls)|

## Intro to C#

C# (C Sharp) is an object-oriented programming (OOP) language developed by Microsoft that is primarily used for creating games. Many popular gaming frameworks, such as Unity, use C#, and this is also the language used for Sansar scripts.

- [Setting up Visual Studio Code](/docs/vscode.md)
- [C# Basics](/docs/c-sharp.md)

## Intro to Sansar Scripts

Sansar scripts use a custom subset of C# that restict the usage to only whitelisted native libraries, for both security and performance reasons. Normally, if a native library is too useful but fails either these two requirements, than a custom implenetation will be provided with some limitations applied; `HttpClient` is a prime example of this.

- [Getting started with Sansar scripts](/docs/sansar-scripts.md)
- [Creating Simple Scripts](/docs/simple-scripts.md)

## Limits

### Environment Limits
|Limit|Max|
|-|:-:|
|User display name length|32|
|Free experiences per user|20|
|Visitors per experience|unlimited|
|Instances per experience|unlimited|
|Visitors per instance|35|
|Empty experience keep-alive|10mins|
|Scene dimensions|+/-2048 (xyz)|

### Scripting Throttles

|Function|Max|Timeframe|
|-|:-:|:-:|
|Rezzing objects|100|1s|
|Local teleport|1|Physics frame*|
|All physics functions|1|Physics frame*|
|Set media url|5|10s|
|Chat messages**|64|1s|
|Http Requests***|10|1s|

> \* A physics frame is normally 1/90th of a second (~11ms), though lag may cause calls to skip frames. If multiple calls of the same function happen in a single frame, then only the last call will apply.

> \*\* Chat messages are limited to 2048 characters.

> \*\*\* Urls are limited to 2048 characters. Payloads are limited to 16kb.

### Scripting Limits

|Limit|Max|
|-|:-:|
|Concurrent coroutines|256|
|Script memory*|32mb|
|Total scene memory|32mb|
|Script upload size|1mb|
|Ticks per second**|10,000,000|

> \* A script with the bare minimum of code is around 4kb of memory.

> \*\* A single boolean logic operation can happen in a single tick. In reality, while code runs at 10 million ticks per second, only 6 million are executed because only part of a server frame is dedicated to scripts. Total ticks are shared with other running scripts, and therefore your script speed is dependent on how many scripts are currently executing code. Sansar API's are guaranteed to be no more than 3000 ticks (~0.3ms) each.

### User body & movement

|Property|Value|
|-|:-:|
|Walking speed|1.7m/s|
|Walking backwards speed|1.4m/s|
|Running speed|4.8m/s|
|Running backwards speed|3.1m/s|
|Strafe running speed|4.0m/s|
|Strafe walking speed|1.4m/s|
|Crouching speed|1.0m/s|
|Crouching backwards speed|0.9m/s|
|Min jump height*|0.9m|
|Max jump height*|1.7m|
|Edge climb max height|0.45m|
|Edge climb min depth|0.29m|
|Slope climb max angle|59 degrees|
|Standing height**|1.65m|
|Crouch height**|1.1m|
|Collision width|1m|

> \* Assuming 1g gravity.

> \*\* Unaffected by avatar scale.

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
