REM copies library compiled with Visual Studio 2010 and .h source file to Resources directories

copy "Microsoft Visual Studio 2010\Release\ExternalMediaLib.lib" "..\Modelica\ExternalMedia 3.2\Resources\Library\ExternalMediaLib.lib" /Y
copy "Microsoft Visual Studio 2010\Release\ExternalMediaLib.lib" "..\Modelica\ExternalMedia 3.2\Resources\Library\ExternalMediaLib.vs2010.lib" /Y
copy "Sources\externalmedialib.h" "..\Modelica\ExternalMedia 3.2\Resources\Include" /Y

copy "Microsoft Visual Studio 2010\Release\ExternalMediaLib.lib" "..\Modelica\ExternalMedia 3.2.1\Resources\Library\ExternalMediaLib.lib" /Y
copy "Microsoft Visual Studio 2010\Release\ExternalMediaLib.lib" "..\Modelica\ExternalMedia 3.2.1\Resources\Library\ExternalMediaLib.vs2010.lib" /Y
copy "Sources\externalmedialib.h" "..\Modelica\ExternalMedia 3.2.1\Resources\Include" /Y

