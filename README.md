# BuzzFes Project

## Overview
BuzzFes is a web application built using Ruby on Rails for the backend and Vue.js for the frontend. This project aims to provide a seamless experience for users, allowing them to interact with the application efficiently.

## Project Structure
The project is organized into two main directories: `backend` and `frontend`.

```
buzzfes
├── backend          # Contains the Rails application
│   ├── Dockerfile   # Docker configuration for Rails
│   ├── Gemfile      # Ruby dependencies
│   ├── Gemfile.lock # Locked versions of gems
│   ├── config
│   │   └── database.yml # Database configuration
│   └── README.md    # Documentation for the backend
├── frontend         # Contains the Vue.js application
│   ├── Dockerfile   # Docker configuration for Vue.js
│   ├── package.json # JavaScript dependencies
│   ├── tsconfig.json # TypeScript configuration
│   ├── src
│   │   └── main.ts  # Entry point for the Vue.js application
│   └── README.md    # Documentation for the frontend
├── docker-compose.yml # Configuration for Docker services
└── README.md        # Documentation for the entire project
```

## Getting Started

### Prerequisites
- Docker
- Docker Compose

### Installation
1. Clone the repository:
   ```
   git clone <repository-url>
   cd buzzfes
   ```

2. Build and run the application using Docker Compose:
   ```
   docker-compose up --build
   ```

### Usage
- The backend API will be available at `http://localhost:3000`.
- The frontend application will be accessible at `http://localhost:8080`.

## Contributing
Contributions are welcome! Please open an issue or submit a pull request for any improvements or bug fixes.

## License
This project is licensed under the MIT License. See the LICENSE file for details.