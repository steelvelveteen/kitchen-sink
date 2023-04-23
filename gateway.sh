#!/bin/bash

# Set solution name
SOLUTION_NAME="AlphaCorp.Gateway"

# Set project names based on solution name
API_PROJECT_NAME="${SOLUTION_NAME}.API"
TEST_PROJECT_NAME="${SOLUTION_NAME}.Tests"

# Create the main solution folder
mkdir "$SOLUTION_NAME"

# Change the working directory to the solution folder
cd "$SOLUTION_NAME"

# Create src and tests folders
mkdir src
mkdir tests

# Create the solution
dotnet new sln -n "$SOLUTION_NAME"

# Create the Web API project
dotnet new webapi -n "$API_PROJECT_NAME" -o "src/$API_PROJECT_NAME"
dotnet sln add "src/$API_PROJECT_NAME/$API_PROJECT_NAME.csproj"

# Create necessary folders
mkdir "src/$API_PROJECT_NAME/Configuration"
mkdir "src/$API_PROJECT_NAME/Middleware"
mkdir "src/$API_PROJECT_NAME/Services"
mkdir "src/$API_PROJECT_NAME/Extensions"

# Create the xUnit test project
dotnet new xunit -n "$TEST_PROJECT_NAME" -o "tests/$TEST_PROJECT_NAME"
dotnet sln add "tests/$TEST_PROJECT_NAME/$TEST_PROJECT_NAME.csproj"

# Set up dependencies
dotnet add "tests/$TEST_PROJECT_NAME/$TEST_PROJECT_NAME.csproj" reference "src/$API_PROJECT_NAME/$API_PROJECT_NAME.csproj"

# Build the solution
echo "Building the solution..."
dotnet build "$SOLUTION_NAME.sln"

# Run the tests
echo "Running tests..."
dotnet test "tests/$TEST_PROJECT_NAME/$TEST_PROJECT_NAME.csproj"

# Add a README.md file
touch README.md

# Add .gitignore file
touch .gitignore
git init

# Add ocelot.json file
touch "src/$API_PROJECT_NAME/ocelot.json"

echo "Done."
