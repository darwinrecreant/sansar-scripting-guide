# Setting up Visual Studio Code

Visual Studio Code (vscode), not to be confused with Visual Studio, is a lightweight IDE that can do C# syntax highlighting, provide api autocompletion, and do type checks. If you are going to write Sansar scripts, then it is highly recommended you start with a proper IDE and not simply notepad.

## First Setup
1. Download/clone/fork [this repository](https://github.com/darwinrecreant/sansar-scripting-guide) and use it as your Sansar projects workspace
2. Install [Visual Studio Code](https://code.visualstudio.com/)
3. In vscode, go to extensions (squares icon) and find and install `C# for Visual Studio Code` by **Microsoft**
4. Install [.NET Core](https://www.microsoft.com/net/core)
5. Install [.NET Framework 4.6.2 Developer Pack](https://www.microsoft.com/en-us/download/details.aspx?id=53321)
6. Edit `get-sansar-lib.bat` and make sure the directory path in robocopy commands point to your Sansar installation on your computer, if it does not then change it and save.
7. Double click `get-sansar-lib.bat` (outside vscode) in the downloaded workspace in step 1, this will copy Sansar assemblies (dlls) and Script Library code to your local directory and will allow autcompletion of api and easily include `LibraryBase.cs` in your projects.
8. Open vscode in the downloaded workspace, open the terminal (<kbd>Ctrl</kbd> + <kbd>~</kbd>), and type `dotnet restore`
9. Close and reopen vscode. You can now create your first [Sansar script](sansar-scripts.md).

## For Every Sansar Client Update
1. Double click `get-sansar-lib.bat` (outside vscode)
2. Open vscode in the downloaded workspace, open the terminal (<kbd>Ctrl</kbd> + <kbd>~</kbd>), and type `dotnet restore`
3. Close and reopen vscode

## Every New Project
1. Create a folder in your workspace, and create your C# files in that. If you need to include scripts from other projects, just add a .json file with paths pointing to your files, which can be uploaded to Sansar for multi file scripts.