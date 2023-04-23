@echo off

:: Set solution name
set SOLUTION_NAME=AlphaCorp.Gateway

:: Set project names based on solution name
set GATEWAY_PROJECT_NAME=%SOLUTION_NAME%
set GATEWAY_TEST_PROJECT_NAME=%SOLUTION_NAME%.Tests

:: Create the main solution folder
md %SOLUTION_NAME%

:: Change the working directory to the solution folder
cd %SOLUTION_NAME%

:: Create src and tests folders
md src
md tests

:: Create the solution
dotnet new sln -n %SOLUTION_NAME%

:: Create the gateway project
dotnet new webapi -n %GATEWAY_PROJECT_NAME% -o src/%GATEWAY_PROJECT_NAME%
dotnet sln add src/%GATEWAY_PROJECT_NAME%/%GATEWAY_PROJECT_NAME%.csproj

:: Create directories within the gateway project
cd src/%GATEWAY_PROJECT_NAME%
md Configuration
md Middleware
md Services
md Extensions

:: Create the ocelot.json file
echo.>ocelot.json

:: Create the xUnit test project
cd ../../
dotnet new xunit -n %GATEWAY_TEST_PROJECT_NAME% -o tests/%GATEWAY_TEST_PROJECT_NAME%
dotnet sln add tests/%GATEWAY_TEST_PROJECT_NAME%/%GATEWAY_TEST_PROJECT_NAME%.csproj

:: Build the solution
echo Building the solution...
dotnet build %SOLUTION_NAME%.sln

:: Run the tests
echo Running tests...
dotnet test tests/%GATEWAY_TEST_PROJECT_NAME%/%GATEWAY_TEST_PROJECT_NAME%.csproj

:: Add a README.md file
echo.>README.md

:: Add .gitignore file
echo.>.gitignore
git init

echo Done.
