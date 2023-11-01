# Clean Architecture in .NET Core

## There are commonly four main layers

1. Domain Layer
2. Application Layer
3. Infrastructure Layer
4. Presentation Layer or **API**

### AlphaIndustries.Domain
Contains the core business logic, entities, value objects, and domain interfaces. This layer is independent of any external dependencies and has no knowledge of other layers.

### AlphaIndustries.Application
Defines the use cases of the application, containing interfaces for services, application services, and data transfer objects (DTOs). It orchestrates the flow of data to and from the Domain Layer.

### AlphaIndustries.Infrastructure
Contains implementations of the interfaces defined in the Domain and Application layers. It manages external concerns like persistence, networking, and third-party libraries.

### AlphaIndustries.API
This is the Presentation Layer, where the API controllers, middleware, and extensions live. It communicates with the Application Layer to perform operations and return results.

**Structure layout**

- AlphaIndustries.sln
  - src
    - AlphaIndustries.Domain
      - Entities
      - Interfaces
      - ValueObjects
      - Enums
    - AlphaIndustries.Application
      - Interfaces
      - Services
      - DTOs
    - AlphaIndustries.Infrastructure
      - Data
        - Repositories
        - Migrations
        - Context
      - Logging
      - Identity
    - AlphaIndustries.API
      - Controllers
      - Extensions
      - Middlewares
  - tests
    - AlphaIndustries.UnitTests
    - AlphaIndustries.IntegrationTests
