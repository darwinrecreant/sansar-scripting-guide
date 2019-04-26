if not exist ".\Assemblies" mkdir ".\Assemblies"
if not exist ".\ScriptLibrary" mkdir ".\ScriptLibrary"
robocopy "D:\Steam\steamapps\common\Sansar\Client\ScriptApi\Assemblies" ".\Assemblies" /E
robocopy "D:\Steam\steamapps\common\Sansar\Client\ScriptApi\Examples\ScriptLibrary" ".\ScriptLibrary" /E
pause 10