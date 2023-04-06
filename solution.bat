@echo off

:: Set solution name
set SOLUTION_NAME=Sentium

:: Set project names based on solution name
set API_PROJECT_NAME=%SOLUTION_NAME%.API
set TEST_PROJECT_NAME=%SOLUTION_NAME%.Tests
set DOMAIN_PROJECT_NAME=%SOLUTION_NAME%.Domain
set INFRASTRUCTURE_PROJECT_NAME=%SOLUTION_NAME%.Infrastructure
set CONTRACTS_PROJECT_NAME=%SOLUTION_NAME%.Contracts
set APPLICATION_PROJECT_NAME=%SOLUTION_NAME%.Application

:: Create the main solution folder
md %SOLUTION_NAME%

:: Change the working directory to the solution folder
cd %SOLUTION_NAME%

:: Create the solution
dotnet new sln -n %SOLUTION_NAME%

:: Create the domain class library project
dotnet new classlib -n %DOMAIN_PROJECT_NAME% -o %DOMAIN_PROJECT_NAME%
dotnet sln add %DOMAIN_PROJECT_NAME%\%DOMAIN_PROJECT_NAME%.csproj

:: Create the Web API project
dotnet new webapi -n %API_PROJECT_NAME% -o %API_PROJECT_NAME%
dotnet sln add %API_PROJECT_NAME%\%API_PROJECT_NAME%.csproj

:: Create the xUnit test project
dotnet new xunit -n %TEST_PROJECT_NAME% -o %TEST_PROJECT_NAME%
dotnet sln add %TEST_PROJECT_NAME%\%TEST_PROJECT_NAME%.csproj

:: Create the infrastructure class library project
dotnet new classlib -n %INFRASTRUCTURE_PROJECT_NAME% -o %INFRASTRUCTURE_PROJECT_NAME%
dotnet sln add %INFRASTRUCTURE_PROJECT_NAME%\%INFRASTRUCTURE_PROJECT_NAME%.csproj

:: Create the contracts class library project
dotnet new classlib -n %CONTRACTS_PROJECT_NAME% -o %CONTRACTS_PROJECT_NAME%
dotnet sln add %CONTRACTS_PROJECT_NAME%\%CONTRACTS_PROJECT_NAME%.csproj

:: Create the application class library project
dotnet new classlib -n %APPLICATION_PROJECT_NAME% -o %APPLICATION_PROJECT_NAME%
dotnet sln add %APPLICATION_PROJECT_NAME%\%APPLICATION_PROJECT_NAME%.csproj

:: Set up dependencies
dotnet add %API_PROJECT_NAME%\%API_PROJECT_NAME%.csproj reference %CONTRACTS_PROJECT_NAME%\%CONTRACTS_PROJECT_NAME%.csproj
dotnet add %API_PROJECT_NAME%\%API_PROJECT_NAME%.csproj reference %APPLICATION_PROJECT_NAME%\%APPLICATION_PROJECT_NAME%.csproj
dotnet add %INFRASTRUCTURE_PROJECT_NAME%\%INFRASTRUCTURE_PROJECT_NAME%.csproj reference %APPLICATION_PROJECT_NAME%\%APPLICATION_PROJECT_NAME%.csproj
dotnet add %APPLICATION_PROJECT_NAME%\%APPLICATION_PROJECT_NAME%.csproj reference %DOMAIN_PROJECT_NAME%\%DOMAIN_PROJECT_NAME%.csproj

:: Build the solution
echo Building the solution...
dotnet build %SOLUTION_NAME%.sln

:: Run the tests
echo Running tests...
dotnet test %TEST_PROJECT_NAME%\%TEST_PROJECT_NAME%.csproj

:: Add a README.md file
echo.>README.md

:: Add .gitignore file
echo.>.gitignore

:: Docker
cd %API_PROJECT_NAME%
echo.>Dockerfile
echo.>.dockerignore

echo Done.
