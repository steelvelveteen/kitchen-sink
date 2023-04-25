# AlphaIndustries

AlphaIndustries is a Clean Architecture .NET solution template, consisting of multiple projects, including a Web API, Domain, Infrastructure, and Application layers, along with unit and integration test projects.

## Solution Structure

The solution is divided into `src` and `tests` folders, containing the main projects and test projects, respectively.

### Main Projects

- **AlphaIndustries.Domain**: Contains domain entities, value objects, enums, exceptions, and events.
- **AlphaIndustries.API**: A Web API project that serves as the main entry point for the application.
- **AlphaIndustries.Infrastructure**: Contains infrastructure-related code, such as data access and external services.
- **AlphaIndustries.Application**: Contains application logic, including commands, queries, and event handlers.

### Test Projects

- **AlphaIndustries.API.Tests**: Contains xUnit tests for the API project.
- **AlphaIndustries.Domain.Tests**: Contains xUnit tests for the Domain project.
- **AlphaIndustries.Infrastructure.Tests**: Contains xUnit tests for the Infrastructure project.
- **AlphaIndustries.Application.Tests**: Contains xUnit tests for the Application project.
- **AlphaIndustries.Integration.Tests**: Contains xUnit integration tests.

## Dependencies

The solution uses various NuGet packages, including:

- Serilog for logging (API layer)
- Dapper for data access (Infrastructure layer)
- Entity Framework Core (Infrastructure layer)
- AutoMapper (Application layer)
- FluentValidation (Application layer)

## Getting Started

To build the solution, navigate to the solution folder and run:

```bash
    dotnet build AlphaIndustries.sln
```

To run the test:

```bash
    dotnet test
```

## License

This project is licensed under the MIT License.
