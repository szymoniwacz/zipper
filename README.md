# README

This README documents the necessary steps to get the application up and running, including API enhancements and new features.

## Ruby Version

- Ensure you are using Ruby version 2.7.2 or later.

## System Dependencies

- MySQL
- Redis

## Configuration

1. Copy the `.env.example` file to `.env` and update the environment variables as needed.
2. Ensure your `database.yml` is properly configured to connect to your MySQL database.
3. Ensure Redis is running.

## Database Creation

Run the following commands to create the database:

```sh
rails db:create
rails db:migrate
```

## How to Run the Test Suite

Run the RSpec test suite:

```sh
rspec spec
```

## Additional Information

For any additional setup or configuration, refer to the official Rails documentation or the project's wiki.

---

### API Enhancements and Features

#### User Authentication API

- Endpoint for user login.
- Secure password handling.

#### File Upload and Encryption

- Allows authenticated users to upload files.
- Files are encrypted with a randomly generated password and packed into a `.zip` archive.
- The user receives a download link and the encryption password upon successful upload.

#### File Listing

- Users can list the files they have uploaded.

#### Testing

- Comprehensive unit tests using RSpec.
- Request tests to ensure API functionality.

#### Documentation

- OpenAPI documentation for the API endpoints.
- Documentation available at `/api/docs` rendered with Swagger UI.
