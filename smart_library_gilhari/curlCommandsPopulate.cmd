REM ===========================================
REM Smart Library System Populate Script
REM ===========================================

IF %1.==. GOTO DefaultPort
SET port=%1
GOTO Proceed

:DefaultPort
SET port=80

:Proceed

echo ** BEGIN OUTPUT ** > curl.log
echo. >> curl.log

echo Using PORT %port% >> curl.log
echo. >> curl.log

echo ** Health Check ** >> curl.log
curl -X GET "http://localhost:%port%/gilhari/v1/health/check" >> curl.log
echo. >> curl.log

echo ** Delete all Libraries ** >> curl.log
curl -X DELETE "http://localhost:%port%/gilhari/v1/Library" >> curl.log
echo. >> curl.log

echo ** Insert Library 1 ** >> curl.log
curl -X POST "http://localhost:%port%/gilhari/v1/Library" ^
-H "Content-Type: application/json" ^
-d @libraryObjectExample1.json >> curl.log
echo. >> curl.log

echo ** Insert Library 2 ** >> curl.log
curl -X POST "http://localhost:%port%/gilhari/v1/Library" ^
-H "Content-Type: application/json" ^
-d @libraryObjectExample2.json >> curl.log
echo. >> curl.log

echo ** Query all Libraries ** >> curl.log
curl -X GET "http://localhost:%port%/gilhari/v1/Library" >> curl.log
echo. >> curl.log

echo ** Shallow Query ** >> curl.log
curl -X GET "http://localhost:%port%/gilhari/v1/Library?deep=false" >> curl.log
echo. >> curl.log

echo ** Get Library with ID=1 ** >> curl.log
curl -X GET "http://localhost:%port%/gilhari/v1/Library/getObjectById?filter=libraryId=1" >> curl.log
echo. >> curl.log

echo ** Query all Books ** >> curl.log
curl -X GET "http://localhost:%port%/gilhari/v1/Book" >> curl.log
echo. >> curl.log

echo ** Query all Members ** >> curl.log
curl -X GET "http://localhost:%port%/gilhari/v1/Member" >> curl.log
echo. >> curl.log

echo ** Query all Staff ** >> curl.log
curl -X GET "http://localhost:%port%/gilhari/v1/Staff" >> curl.log
echo. >> curl.log

echo ** Query all Library Transactions ** >> curl.log
curl -X GET "http://localhost:%port%/gilhari/v1/LibraryTransaction" >> curl.log
echo. >> curl.log

echo ** Count Libraries ** >> curl.log
curl -X GET "http://localhost:%port%/gilhari/v1/Library/getAggregate?attribute=libraryId&aggregateType=COUNT" >> curl.log
echo. >> curl.log

echo ** Count Books ** >> curl.log
curl -X GET "http://localhost:%port%/gilhari/v1/Book/getAggregate?attribute=bookId&aggregateType=COUNT" >> curl.log
echo. >> curl.log

echo ** Query Libraries with filter libraryId=1 ** >> curl.log
curl -X GET "http://localhost:%port%/gilhari/v1/Library?filter=libraryId=1" >> curl.log
echo. >> curl.log

type curl.log