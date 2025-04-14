# Ruby on Rails API Base Template

A base template for Ruby on Rails API-only applications with authentication and documentation.

## Features

- Ruby 3.2.2
- Rails 7.1.3
- PostgreSQL database
- API-only mode
- Devise authentication with JWT
- RSpec for testing
- Swagger documentation
- Docker and Docker Compose setup

## Requirements

- Docker
- Docker Compose

## Getting Started

1. Clone the repository:

```bash
git clone https://github.com/yourusername/ror-backend-base.git
cd ror-backend-base
```

2. Start the application:

```bash
docker-compose up
```

3. Access the API documentation:

Open your browser and navigate to http://localhost:3000/api-docs

## API Endpoints

### Authentication

- POST /api/v1/auth/sign_up - Register a new user
- POST /api/v1/auth/sign_in - Sign in and get JWT token
- DELETE /api/v1/auth/sign_out - Sign out
- GET /api/v1/auth/me - Get current user profile

## Testing

Run the tests with:

```bash
docker-compose run --rm web rspec
```

## Generate Swagger Documentation

```bash
docker-compose run --rm web rails rswag:specs:swaggerize
```

## Cross-Platform Development

For cross-platform development, ensure your Gemfile.lock supports multiple platforms:

```bash
# For Mac M1/M2 (ARM)
bundle lock --add-platform aarch64-linux

# For Intel/AMD
bundle lock --add-platform x86_64-linux
```

## License

This project is available as open source under the terms of the MIT License.
