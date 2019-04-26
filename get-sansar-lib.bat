if not exist ".\Assemblies" mkdir ".\Assemblies"
if not exist ".\ScriptLibrary" mkdir ".\ScriptLibrary"
if not exist ".\Examples" mkdir ".\Examples"
robocopy "D:\Steam\steamapps\common\Sansar\Client\ScriptApi\Assemblies" ".\Assemblies" /E
robocopy "D:\Steam\steamapps\common\Sansar\Client\ScriptApi\Examples\ScriptLibrary" ".\ScriptLibrary" /E
robocopy "D:\Steam\steamapps\common\Sansar\Client\ScriptApi\Examples" ".\Examples"
pause 10