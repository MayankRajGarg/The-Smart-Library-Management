REM Compile java source files with JDK 1.8 compatibility
REM Set JX_HOME to the root directory of Gilhari installation.
set JX_HOME=..

REM With JDK 1.8
javac -d .\bin -cp .;%JX_HOME%\libs\jxclasses.jar;%JX_HOME%\libs\json-20240303.jar @sources.txt

REM With JDK 1.9 or higher 
REM javac -d .\bin --release 8 -cp .;%JX_HOME%\libs\jxclasses.jar;%JX_HOME%\libs\json-20240303.jar @sources.txt
