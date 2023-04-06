#!/bin/bash

# Set solution name
SOLUTION_NAME=Alpha

# Set project names based on solution name
API_PROJECT_NAME=${SOLUTION_NAME}.API
TEST_PROJECT_NAME=${SOLUTION_NAME}.Tests
DOMAIN_PROJECT_NAME=${SOLUTION_NAME}.Domain
INFRASTRUCTURE_PROJECT_NAME=${SOLUTION_NAME}.Infrastructure
APPLICATION_PROJECT_NAME=${SOLUTION_NAME}.Application

# Create the main solution folder
mkdir $SOLUTION_NAME

# Change the working directory to the solution folder
cd $SOLUTION_NAME

# Create src and tests folders
mkdir src
mkdir tests

# Create the solution
dotnet new sln -n $SOLUTION_NAME

# Create the domain class library project
dotnet new classlib -n $DOMAIN_PROJECT_NAME -o src/$DOMAIN_PROJECT_NAME
dotnet sln add src/$DOMAIN_PROJECT_NAME/$DOMAIN_PROJECT_NAME.csproj

# Create the Web API project
dotnet new webapi -n $API_PROJECT_NAME -o src/$API_PROJECT_NAME
dotnet sln add src/$API_PROJECT_NAME/$API_PROJECT_NAME.csproj

# Create the infrastructure class library project
dotnet new classlib -n $INFRASTRUCTURE_PROJECT_NAME -o src/$INFRASTRUCTURE_PROJECT_NAME
dotnet sln add src/$INFRASTRUCTURE_PROJECT_NAME/$INFRASTRUCTURE_PROJECT_NAME.csproj

# Create the application class library project
dotnet new classlib -n $APPLICATION_PROJECT_NAME -o src/$APPLICATION_PROJECT_NAME
dotnet sln add src/$APPLICATION_PROJECT_NAME/$APPLICATION_PROJECT_NAME.csproj

# Create the xUnit test project
dotnet new xunit -n $TEST_PROJECT_NAME -o tests/$TEST_PROJECT_NAME
dotnet sln add tests/$TEST_PROJECT_NAME/$TEST_PROJECT_NAME.csproj

# Set up dependencies
dotnet add src/$API_PROJECT_NAME/$API_PROJECT_NAME.csproj reference src/$APPLICATION_PROJECT_NAME/$APPLICATION_PROJECT_NAME.csproj
dotnet add src/$API_PROJECT_NAME/$API_PROJECT_NAME.csproj reference src/$INFRASTRUCTURE_PROJECT_NAME/$INFRASTRUCTURE_PROJECT_NAME.csproj
dotnet add src/$INFRASTRUCTURE_PROJECT_NAME/$INFRASTRUCTURE_PROJECT_NAME.csproj reference src/$APPLICATION_PROJECT_NAME/$APPLICATION_PROJECT_NAME.csproj
dotnet add src/$APPLICATION_PROJECT_NAME/$APPLICATION_PROJECT_NAME.csproj reference src/$DOMAIN_PROJECT_NAME/$DOMAIN_PROJECT_NAME.csproj

# Build the solution
echo "Building the solution..."
dotnet build ${SOLUTION_NAME}.sln

# Run the tests
echo "Running tests..."
dotnet test tests/$TEST_PROJECT_NAME/$TEST_PROJECT_NAME.csproj

# Add a README.md file
touch README.md

# Add .gitignore file
touch .gitignore
git init

# Docker
touch Dockerfile
touch .dockerignore

echo "Done."
