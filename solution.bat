@echo off

:: Set solution name
set SOLUTION_NAME=Alpha

:: Set project names based on solution name
set API_PROJECT_NAME=%SOLUTION_NAME%.API
set DOMAIN_PROJECT_NAME=%SOLUTION_NAME%.Domain
set INFRASTRUCTURE_PROJECT_NAME=%SOLUTION_NAME%.Infrastructure
set APPLICATION_PROJECT_NAME=%SOLUTION_NAME%.Application

:: Set project tests names based on solution name
set API_TEST_PROJECT_NAME=%SOLUTION_NAME%.API.Tests
set DOMAIN_TEST_PROJECT_NAME=%SOLUTION_NAME%.Domain.Tests
set INFRASTRUCTURE_TEST_PROJECT_NAME=%SOLUTION_NAME%.Infrastucture.Tests
set APPLICATION_TEST_PROJECT_NAME=%SOLUTION_NAME%.Application.Tests

:: Create the main solution folder
md %SOLUTION_NAME%

:: Change the working directory to the solution folder
cd %SOLUTION_NAME%

:: Create src and tests folders
md src
md tests

:: Create the solution
dotnet new sln -n %SOLUTION_NAME%

:: Create the domain class library project
dotnet new classlib -n %DOMAIN_PROJECT_NAME% -o src/%DOMAIN_PROJECT_NAME%
dotnet sln add src/%DOMAIN_PROJECT_NAME%\%DOMAIN_PROJECT_NAME%.csproj

:: Add an Entities directory under the Domain project
md src/%DOMAIN_PROJECT_NAME%/Entities

:: Create the Web API project
dotnet new webapi -n %API_PROJECT_NAME% -o src/%API_PROJECT_NAME%
dotnet sln add src/%API_PROJECT_NAME%\%API_PROJECT_NAME%.csproj

:: Create the infrastructure class library project
dotnet new classlib -n %INFRASTRUCTURE_PROJECT_NAME% -o src/%INFRASTRUCTURE_PROJECT_NAME%
dotnet sln add src/%INFRASTRUCTURE_PROJECT_NAME%\%INFRASTRUCTURE_PROJECT_NAME%.csproj


:: Create the application class library project
dotnet new classlib -n %APPLICATION_PROJECT_NAME% -o src/%APPLICATION_PROJECT_NAME%
dotnet sln add src/%APPLICATION_PROJECT_NAME%\%APPLICATION_PROJECT_NAME%.csproj

:: Create the xUnit API test project
dotnet new xunit -n %API_TEST_PROJECT_NAME% -o tests/%API_TEST_PROJECT_NAME%
dotnet sln add tests/%API_TEST_PROJECT_NAME%\%API_TEST_PROJECT_NAME%.csproj

:: Create the xUnit domain test project
dotnet new xunit -n %DOMAIN_TEST_PROJECT_NAME% -o tests/%DOMAIN_TEST_PROJECT_NAME%
dotnet sln add tests/%DOMAIN_TEST_PROJECT_NAME%\%DOMAIN_TEST_PROJECT_NAME%.csproj

:: Create the xUnit application test project
dotnet new xunit -n %APPLICATION_TEST_PROJECT_NAME% -o tests/%APPLICATION_TEST_PROJECT_NAME%
dotnet sln add tests/%APPLICATION_TEST_PROJECT_NAME%\%APPLICATION_TEST_PROJECT_NAME%.csproj

:: Create the xUnit infrastructure test project
dotnet new xunit -n %INFRASTRUCTURE_TEST_PROJECT_NAME% -o tests/%INFRASTRUCTURE_TEST_PROJECT_NAME%
dotnet sln add tests/%INFRASTRUCTURE_TEST_PROJECT_NAME%\%INFRASTRUCTURE_TEST_PROJECT_NAME%.csproj

:: Set up dependencies
dotnet add src/%API_PROJECT_NAME%\%API_PROJECT_NAME%.csproj reference src/%APPLICATION_PROJECT_NAME%\%APPLICATION_PROJECT_NAME%.csproj
dotnet add src/%API_PROJECT_NAME%\%API_PROJECT_NAME%.csproj reference src/%INFRASTRUCTURE_PROJECT_NAME%\%INFRASTRUCTURE_PROJECT_NAME%.csproj
dotnet add src/%INFRASTRUCTURE_PROJECT_NAME%\%INFRASTRUCTURE_PROJECT_NAME%.csproj reference src/%APPLICATION_PROJECT_NAME%\%APPLICATION_PROJECT_NAME%.csproj
dotnet add src/%APPLICATION_PROJECT_NAME%\%APPLICATION_PROJECT_NAME%.csproj reference src/%DOMAIN_PROJECT_NAME%\%DOMAIN_PROJECT_NAME%.csproj

:: Set up test project dependencies
dotnet add tests\%API_TEST_PROJECT_NAME%\%API_TEST_PROJECT_NAME%.csproj reference src\%API_PROJECT_NAME%\%API_PROJECT_NAME%.csproj
dotnet add tests\%APPLICATION_TEST_PROJECT_NAME%\%APPLICATION_TEST_PROJECT_NAME%.csproj reference src\%APPLICATION_PROJECT_NAME%
dotnet add tests\%DOMAIN_TEST_PROJECT_NAME%\%DOMAIN_TEST_PROJECT_NAME%.csproj reference src\%DOMAIN_PROJECT_NAME%\%DOMAIN_PROJECT_NAME%.csproj
dotnet add tests\%INFRASTRUCTURE_TEST_PROJECT_NAME%\%INFRASTRUCTURE_TEST_PROJECT_NAME%.csproj reference src\%INFRASTRUCTURE_PROJECT_NAME%\%INFRASTRUCTURE_PROJECT_NAME%.csproj


:: Build the solution
echo Building the solution...
dotnet build %SOLUTION_NAME%.sln

:: Run the tests
echo Running tests...
dotnet test tests/%TEST_PROJECT_NAME%\%TEST_PROJECT_NAME%.csproj

:: Add a README.md file
echo.>README.md

:: Add .gitignore file
echo.>.gitignore
git init

:: Docker
echo.>Dockerfile
echo.>.dockerignore

echo Done.
