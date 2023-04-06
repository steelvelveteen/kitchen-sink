# Use the official .NET SDK image as the build stage
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build

# Set the working directory
WORKDIR /src

# Copy the solution file and restore the dependencies
COPY ["Bubber.sln", "./"]
COPY ["Bubber.API/Bubber.API.csproj", "Bubber.API/"]
COPY ["Bubber.Tests/Bubber.Tests.csproj", "Bubber.Tests/"]
COPY ["Bubber.Domain/Bubber.Domain.csproj", "Bubber.Domain/"]
COPY ["Bubber.Infrastructure/Bubber.Infrastructure.csproj", "Bubber.Infrastructure/"]
COPY ["Bubber.Contracts/Bubber.Contracts.csproj", "Bubber.Contracts/"]
COPY ["Bubber.Application/Bubber.Application.csproj", "Bubber.Application/"]
RUN dotnet restore "Bubber.sln"

# Copy the rest of the source code
COPY . .

# Build the entire solution
RUN dotnet build "Bubber.sln" -c Release -o /app/build

# Publish the Web API project
RUN dotnet publish "Bubber.API/Bubber.API.csproj" -c Release -o /app/publish

# Use the official .NET runtime image as the final stage
FROM mcr.microsoft.com/dotnet/aspnet:6.0

# Set the working directory
WORKDIR /app

# Copy the published output from the build stage
COPY --from=build /app/publish .

# Expose the API port
EXPOSE 80
EXPOSE 443

# Set the entrypoint for the application
ENTRYPOINT ["dotnet", "Bubber.API.dll"]

