# README

This README documents the necessary steps to get the application up and running.

## Ruby Version
- Ensure you are using Ruby version 2.7.2 or later.

## System Dependencies
- MySQL

## Configuration
1. Copy the `.env.example` file to `.env` and update the environment variables as needed.
2. Ensure your `database.yml` is properly configured to connect to your MySQL database.

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
