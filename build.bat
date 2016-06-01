rmdir /s /q bin
mkdir bin
set MSBUILD=C:\Program Files\MSBuild\14.0\Bin\msbuild.exe
copy app.config bin\FSharp.Compiler.Service.dll.config
copy app.config bin\Tehanu.Attributes.exe.config       
copy app.config bin\Tehanu.Core.dll.config
copy app.config bin\Tehanu.Attributes.Parser.exe.config           
copy app.config bin\Tehanu.FSharp.dll.config   
copy app.config bin\Tehanu.FStar.Printer.exe.config           
copy app.config bin\Tehanu.Tests.exe.config                  
fsc -a -o "bin\Tehanu.Attributes.dll" "Tehanu.Attributes\tehanu.attributes.fs" 2> out05.txt               
fsc -a -o "bin\Tehanu.Core.dll" "Tehanu.Core\tehanu.core.fs" 2> out10.txt               
copy packages\FsLexYacc.Runtime\lib\net40\* bin\*                  
packages\FsLexYacc\build\fslex.exe --unicode Tehanu.Attributes.Parser\lex.fsl
packages\FsLexYacc\build\fsyacc.exe --module Parser Tehanu.Attributes.Parser\parser.fsy
fsc -a -o "bin\Tehanu.Attributes.Parser.dll" -r:"FsLexYacc.Runtime.dll" -r:"bin\Tehanu.Core.dll"  "Tehanu.Attributes.Parser\parser.fsi" "Tehanu.Attributes.Parser\parser.fs" "Tehanu.Attributes.Parser\lex.fs" "Tehanu.Attributes.Parser\main.fs" 2> out15.txt                                   
copy packages\FSharp.Core\lib\net40\* bin\*
copy packages\FSharp.Compiler.Service\lib\net40\FSharp.Compiler.Service.dll bin\FSharp.Compiler.Service.dll
fsc -a -o "bin\Tehanu.FSharp.dll" -r:"bin\Tehanu.Core.dll" -r:"bin\Tehanu.Attributes.Parser.dll" -r:"bin\FSharp.Compiler.Service.dll" "Tehanu.FSharp\tehanu.fsharp.fs" 2> out20.txt
fsc -a -o "bin\Tehanu.FStar.Printer.dll" -r:"bin\Tehanu.Core.dll" "Tehanu.FStar.Printer\tehanu.fstar.printer.fs" 2> out25.txt 
copy packages\NUnit\lib\net40\nunit.framework.dll bin\nunit.framework.dll
copy packages\NUnitLite\lib\net40\nunitlite.dll bin\nunitlite.dll
fsc -o "bin\Tehanu.Tests.exe" -r:"bin\Tehanu.Core.dll" -r:"bin\Tehanu.FStar.Printer.dll" -r:"bin\Tehanu.FSharp.dll" -r:"nunitlite.dll" -r:"bin\nunit.framework.dll" "Tehanu.Tests\tests.fs" 2> out30.txt 
cd FStar
src\VS\nuget-restore.bat
"%MSBUILD%" src\VS\FStar.sln
cd ..
find "error" out05.txt    
find "error" out10.txt    
find "error" out15.txt
find "error" out20.txt
find "error" out25.txt
find "error" out30.txt
