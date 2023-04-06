@echo off

:: Set solution name
set SOLUTION_NAME=Alpha

:: Set project names based on solution name
set API_PROJECT_NAME=%SOLUTION_NAME%.API
set TEST_PROJECT_NAME=%SOLUTION_NAME%.Tests
set DOMAIN_PROJECT_NAME=%SOLUTION_NAME%.Domain
set INFRASTRUCTURE_PROJECT_NAME=%SOLUTION_NAME%.Infrastructure
set APPLICATION_PROJECT_NAME=%SOLUTION_NAME%.Application

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

:: Create the Web API project
dotnet new webapi -n %API_PROJECT_NAME% -o src/%API_PROJECT_NAME%
dotnet sln add src/%API_PROJECT_NAME%\%API_PROJECT_NAME%.csproj


:: Create the infrastructure class library project
dotnet new classlib -n %INFRASTRUCTURE_PROJECT_NAME% -o src/%INFRASTRUCTURE_PROJECT_NAME%
dotnet sln add src/%INFRASTRUCTURE_PROJECT_NAME%\%INFRASTRUCTURE_PROJECT_NAME%.csproj


:: Create the application class library project
dotnet new classlib -n %APPLICATION_PROJECT_NAME% -o src/%APPLICATION_PROJECT_NAME%
dotnet sln add src/%APPLICATION_PROJECT_NAME%\%APPLICATION_PROJECT_NAME%.csproj

:: Create the xUnit test project
dotnet new xunit -n %TEST_PROJECT_NAME% -o tests/%TEST_PROJECT_NAME%
dotnet sln add tests/%TEST_PROJECT_NAME%\%TEST_PROJECT_NAME%.csproj

:: Set up dependencies
dotnet add src/%API_PROJECT_NAME%\%API_PROJECT_NAME%.csproj reference src/%APPLICATION_PROJECT_NAME%\%APPLICATION_PROJECT_NAME%.csproj
dotnet add src/%API_PROJECT_NAME%\%API_PROJECT_NAME%.csproj reference src/%INFRASTRUCTURE_PROJECT_NAME%\%INFRASTRUCTURE_PROJECT_NAME%.csproj
dotnet add src/%INFRASTRUCTURE_PROJECT_NAME%\%INFRASTRUCTURE_PROJECT_NAME%.csproj reference src/%APPLICATION_PROJECT_NAME%\%APPLICATION_PROJECT_NAME%.csproj
dotnet add src/%APPLICATION_PROJECT_NAME%\%APPLICATION_PROJECT_NAME%.csproj reference src/%DOMAIN_PROJECT_NAME%\%DOMAIN_PROJECT_NAME%.csproj

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

:: Docker
echo.>Dockerfile
echo.>.dockerignore

echo Done.
