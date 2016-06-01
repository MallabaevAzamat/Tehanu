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
fsc -a -o "bin\Tehanu.Attributes.dll" "Tehanu.Attributes\tehanu.attributes.fs" 2> out050.txt               
fsc -a -o "bin\Tehanu.Core.dll" "Tehanu.Core\tehanu.core.fs" 2> out100.txt               
copy packages\FsLexYacc.Runtime\lib\net40\* bin\*                  
packages\FsLexYacc\build\fslex.exe --unicode Tehanu.Attributes.Parser\lex.fsl
packages\FsLexYacc\build\fsyacc.exe --module Parser Tehanu.Attributes.Parser\parser.fsy
fsc -a -o "bin\Tehanu.Attributes.Parser.dll" -r:"FsLexYacc.Runtime.dll" -r:"bin\Tehanu.Core.dll"  "Tehanu.Attributes.Parser\parser.fsi" "Tehanu.Attributes.Parser\parser.fs" "Tehanu.Attributes.Parser\lex.fs" "Tehanu.Attributes.Parser\main.fs" 2> out150.txt                                   
copy packages\FSharp.Core\lib\net40\* bin\*
copy packages\FSharp.Compiler.Service\lib\net40\FSharp.Compiler.Service.dll bin\FSharp.Compiler.Service.dll
fsc -a -o "bin\Tehanu.FSharp.dll" -r:"bin\Tehanu.Core.dll" -r:"bin\Tehanu.Attributes.Parser.dll" -r:"bin\FSharp.Compiler.Service.dll" "Tehanu.FSharp\tehanu.fsharp.fs" 2> out200.txt
fsc -a -o "bin\Tehanu.FSharp.Quote.dll" -r:"bin\Tehanu.Core.dll" -r:"bin\Tehanu.Attributes.Parser.dll" "Tehanu.FSharp.Quote\tehanu.fsharp.quote.fs" 2> out225.txt
fsc -a -o "bin\Tehanu.FStar.Printer.dll" -r:"bin\Tehanu.Core.dll" "Tehanu.FStar.Printer\tehanu.fstar.printer.fs" 2> out250.txt 
copy packages\NUnit\lib\net40\nunit.framework.dll bin\nunit.framework.dll
copy packages\NUnitLite\lib\net40\nunitlite.dll bin\nunitlite.dll
fsc -o "bin\Tehanu.Tests.exe" -r:"bin\Tehanu.Core.dll" -r:"bin\Tehanu.FSharp.Quote.dll" -r:"bin\Tehanu.FStar.Printer.dll" -r:"bin\Tehanu.FSharp.dll" -r:"nunitlite.dll" -r:"bin\nunit.framework.dll" "Tehanu.Tests\tests.fs" 2> out300.txt 
rem ----
rem -- For native Tehanu.FStar backend --
rem cd FStar
rem src\VS\nuget-restore.bat
rem "%MSBUILD%" src\VS\FStar.sln
rem cd ..
rem copy FStar\bin\* bin\*
rem ----
find "error" out050.txt    
find "error" out100.txt    
find "error" out150.txt
find "error" out200.txt
find "error" out225.txt
find "error" out250.txt
find "error" out300.txt
