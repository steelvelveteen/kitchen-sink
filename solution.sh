#!/bin/bash

# Set solution name
SOLUTION_NAME=Alpha

# Set project names based on solution name
API_PROJECT_NAME=${SOLUTION_NAME}.API
DOMAIN_PROJECT_NAME=${SOLUTION_NAME}.Domain
INFRASTRUCTURE_PROJECT_NAME=${SOLUTION_NAME}.Infrastructure
APPLICATION_PROJECT_NAME=${SOLUTION_NAME}.Application
INTEGRATION_PROJECT_NAME=${SOLUTION_NAME}.Integration

API_TEST_PROJECT_NAME=${SOLUTION_NAME}.API.Tests
DOMAIN_TEST_PROJECT_NAME=${SOLUTION_NAME}.Domain.Tests
INFRASTRUCTURE_TEST_PROJECT_NAME=${SOLUTION_NAME}.Infrastructure.Tests
APPLICATION_TEST_PROJECT_NAME=${SOLUTION_NAME}.Application.Tests

# Create the main solution folder
mkdir $SOLUTION_NAME

# Change the working directory to the solution folder
cd $SOLUTION_NAME

# Create src and tests folders
mkdir src
mkdir tests

# Create the solution
dotnet new sln -n $SOLUTION_NAME

# Create the Web API project
dotnet new webapi -n $API_PROJECT_NAME -o src/$API_PROJECT_NAME
dotnet sln add src/$API_PROJECT_NAME/$API_PROJECT_NAME.csproj

# Create the application class library project
dotnet new classlib -n $APPLICATION_PROJECT_NAME -o src/$APPLICATION_PROJECT_NAME
dotnet sln add src/$APPLICATION_PROJECT_NAME/$APPLICATION_PROJECT_NAME.csproj

# Add relevant directories under Application
mkdir src/$APPLICATION_PROJECT_NAME/Common
mkdir src/$APPLICATION_PROJECT_NAME/SampleDomain
mkdir src/$APPLICATION_PROJECT_NAME/SampleDomain/Commands
mkdir src/$APPLICATION_PROJECT_NAME/SampleDomain/Queries
mkdir src/$APPLICATION_PROJECT_NAME/SampleDomain/EventHandlers


# Create the infrastructure class library project
dotnet new classlib -n $INFRASTRUCTURE_PROJECT_NAME -o src/$INFRASTRUCTURE_PROJECT_NAME
dotnet sln add src/$INFRASTRUCTURE_PROJECT_NAME/$INFRASTRUCTURE_PROJECT_NAME.csproj

# Create the domain class library project
dotnet new classlib -n $DOMAIN_PROJECT_NAME -o src/$DOMAIN_PROJECT_NAME
dotnet sln add src/$DOMAIN_PROJECT_NAME/$DOMAIN_PROJECT_NAME.csproj

# Add the relevant directories under Domain
mkdir src/$DOMAIN_PROJECT_NAME/Entities
mkdir src/$DOMAIN_PROJECT_NAME/Common
mkdir src/$DOMAIN_PROJECT_NAME/Enums
mkdir src/$DOMAIN_PROJECT_NAME/Events
mkdir src/$DOMAIN_PROJECT_NAME/ValueObjects
mkdir src/$DOMAIN_PROJECT_NAME/Exceptions
mkdir src/$DOMAIN_PROJECT_NAME/Events

## Tests
# Create the xUnit test project
dotnet new xunit -n $API_TEST_PROJECT_NAME -o tests/$API_TEST_PROJECT_NAME
dotnet sln add tests/$API_TEST_PROJECT_NAME/$API_TEST_PROJECT_NAME.csproj

# Create the xUnit application test project
dotnet new xunit -n $APPLICATION_TEST_PROJECT_NAME -o tests/$APPLICATION_TEST_PROJECT_NAME
dotnet sln add tests/$APPLICATION_TEST_PROJECT_NAME/$APPLICATION_TEST_PROJECT_NAME.csproj

# Create the infrastructure test project
dotnet new xunit -n $INFRASTRUCTURE_TEST_PROJECT_NAME -o tests/$INFRASTRUCTURE_TEST_PROJECT_NAME
dotnet sln add tests/$INFRASTRUCTURE_TEST_PROJECT_NAME/$INFRASTRUCTURE_TEST_PROJECT_NAME.csproj

# Create the xUnit domain test project
dotnet new xunit -n $DOMAIN_TEST_PROJECT_NAME -o tests/$DOMAIN_TEST_PROJECT_NAME
dotnet sln add tests/$DOMAIN_TEST_PROJECT_NAME/$DOMAIN_TEST_PROJECT_NAME.csproj

# Set up dependencies
dotnet add src/$API_PROJECT_NAME/$API_PROJECT_NAME.csproj reference src/$APPLICATION_PROJECT_NAME/$APPLICATION_PROJECT_NAME.csproj
dotnet add src/$API_PROJECT_NAME/$API_PROJECT_NAME.csproj reference src/$INFRASTRUCTURE_PROJECT_NAME/$INFRASTRUCTURE_PROJECT_NAME.csproj
dotnet add src/$INFRASTRUCTURE_PROJECT_NAME/$INFRASTRUCTURE_PROJECT_NAME.csproj reference src/$APPLICATION_PROJECT_NAME/$APPLICATION_PROJECT_NAME.csproj
dotnet add src/$APPLICATION_PROJECT_NAME/$APPLICATION_PROJECT_NAME.csproj reference src/$DOMAIN_PROJECT_NAME/$DOMAIN_PROJECT_NAME.csproj

# Set up test project dependencies
dotnet add tests/$API_TEST_PROJECT_NAME/$API_TEST_PROJECT_NAME.csproj reference src/$API_PROJECT_NAME/$API_PROJECT_NAME.csproj
dotnet add tests/$APPLICATION_TEST_PROJECT_NAME/$APPLICATION_TEST_PROJECT_NAME.csproj reference src/$APPLICATION_PROJECT_NAME
dotnet add tests/$DOMAIN_TEST_PROJECT_NAME/$DOMAIN_TEST_PROJECT_NAME.csproj reference src/$DOMAIN_PROJECT_NAME/$DOMAIN_PROJECT_NAME.csproj
dotnet add tests/$INFRASTRUCTURE_TEST_PROJECT_NAME/$INFRASTRUCTURE_TEST_PROJECT_NAME.csproj reference src/$INFRASTRUCTURE_PROJECT_NAME/$INFRASTRUCTURE_PROJECT_NAME.csproj

# Build the solution
echo "Building the solution..."
dotnet build ${SOLUTION_NAME}.sln

# Run the tests
echo "Running tests..."
dotnet test tests/$API_TEST_PROJECT_NAME/$API_TEST_PROJECT_NAME.csproj

# Add a README.md file
touch README.md

# Add .gitignore file
touch .gitignore
git init

# Docker
touch Dockerfile
touch .dockerignore

echo "Done."
