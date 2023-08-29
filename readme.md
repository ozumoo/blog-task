# JSON API Service Documentation

This documentation outlines the JSON API service built to handle users, posts, ratings, and feedbacks based on the specified requirements in `task.md` defention . The service is built using Ruby and utilizes the ActiveRecord framework for database operations. The API endpoints can be interacted with using CURL commands.

## Installation

1. Clone the repository:
   ```
   git clone https://github.com/ozumoo/blog-task.git
   ```

2. Navigate to the project directory:
   ```
   cd blog-task
   ```

3. Install the required gems using Bundler:
   ```
   bundle install
   ```

4. Create Database:
   ```
   bundle exec rake db:create
   ```

5. Set up the database and run migrations:
   ```
   bundle exec rake db:migrate
   ```

6. Start the server:
   ```
   bundle exec rackup
   ```

## Docker Installation

Docker is a containerization platform that allows you to package and distribute applications along with their dependencies. Follow these steps to install Docker on your system:

### Windows

1. **Installation Steps:**
   - Download the [Docker Desktop Installer](https://desktop.docker.com/win/stable/Docker%20Desktop%20Installer.exe) from the official Docker website.
   - Run the installer and follow the on-screen instructions to complete the installation.
   - Once installed, Docker Desktop will be accessible from the system tray.

### macOS

1. **System Requirements:**
   - macOS 10.14 Mojave or later
   - Hardware support for virtualization

2. **Installation Steps:**
   - Download the [Docker Desktop for Mac Installer](https://desktop.docker.com/mac/stable/Docker.dmg) from the official Docker website.
   - Open the downloaded DMG file and drag the Docker icon into the Applications folder.
   - Launch Docker from the Applications folder or Spotlight.

### Linux

1. **System Requirements:**
   - A 64-bit version of one of the following Linux distributions:
     - Ubuntu 20.04 or higher
     - Debian 10 or higher
     - CentOS 7 or higher
   - A modern kernel (4.9 or later) with cgroups and namespaces support.

2. **Installation Steps:**
   - Visit the [official Docker installation guide for Linux](https://docs.docker.com/engine/install/) and follow the instructions for your specific distribution.
   - After installing Docker, you may need to add your user to the `docker` group to run Docker commands without using `sudo`.

### Verifying Installation

To verify that Docker is installed and working correctly, open a terminal and run the following command:

```sh
docker --version
```

You should see the version information of Docker displayed.

---

After successfully installing Docker, you'll be ready to use it for building, running, and managing containers.

---

I apologize for misunderstanding your request. Here's how you can add a section to your technical documentation for Docker and Docker Compose usage in your project:

---

## Using Docker and Docker Compose

[Docker](https://www.docker.com/) and [Docker Compose](https://docs.docker.com/compose/) are powerful tools for containerizing and managing applications. They allow you to define and manage your application's environment in a consistent and isolated manner. This section provides instructions on how to set up and use Docker and Docker Compose for running your application.

### Docker Installation

Before using Docker and Docker Compose, ensure that you have Docker installed on your system. Refer to the [Docker Installation](#docker-installation) section for installation instructions tailored to your operating system.

### Docker Compose Installation

[Docker Compose](https://docs.docker.com/compose/) is a tool for defining and running multi-container Docker applications using a YAML file. If you're using Docker Desktop on Windows or macOS, Docker Compose is included and no additional installation is needed. For Linux users, you might need to install Docker Compose separately by following the instructions on the [Docker Compose installation page](https://docs.docker.com/compose/install/).

### Using Docker Compose

1. **Navigate to Your Project Directory:**
   Open a terminal and navigate to the directory containing your application code and the `docker-compose.yml` file.

2. **Start Containers:**
   To start your application and its associated services, use the following command:
   ```sh
   docker-compose up
   ```
   This command reads the `docker-compose.yml` file, pulls necessary images, and starts the containers.

3. **Access the Application:**
   Once the containers are up and running, your application should be accessible at the specified port. For example, if your application runs on port 3000, you can access it in a web browser at `http://localhost:3000`.

4. **Stop Containers:**
   To stop and remove the containers, use the following command:
   ```sh
   docker-compose down
   ```
   This command stops and removes the containers, networks, and volumes defined in the `docker-compose.yml` file.

### Running Rake Tasks with Docker

If your application relies on Rake tasks, you can execute them within a Docker container to ensure consistent and isolated execution. Here's an example command to run a Rake task using Docker Compose:
```sh
docker-compose run app rake <your_task_name>
```

### Running Tests with Docker

To run tests for your application using Docker, you can use a similar approach. Here's an example command to run tests within a Docker container:
```sh
docker-compose run app rspec
```

Remember that Docker provides isolation, but it's important to configure your Docker environment to match your application's needs. Ensure that your `docker-compose.yml` file and Dockerfiles are properly configured.

---

With Docker and Docker Compose, you can streamline your development and testing processes, ensuring consistency across different environments.

---

Feel free to customize the instructions based on your project's structure and requirements.
## API Endpoints

### Create User

```shell
curl -X POST http://{{host}}:{{port}}/users -d "email=user@example.com"
```

### Create Post

```shell
curl -X POST http://{{host}}:{{port}}/posts -d "title=Post Title" -d "content=Post Content" -d "author_login=author@example.com" -d "author_ip=127.0.0.1"
```

### Rate Post

```shell
curl -X POST http://{{host}}:{{port}}/ratings -d "post_id=1" -d "value=4"
```

### Get Top N Posts by Average Rating

```shell
curl http://{{host}}:{{port}}/posts/top_rated?n=5
```

### Get IPs and Author Logins

```shell
curl http://{{host}}:{{port}}/posts/author_ips
```

### Add Feedback

```shell
curl -X POST http://{{host}}:{{port}}/feedbacks -d "user_id=1" -d "post_id=1" -d "comment=Great post!"
```

### Get Feedbacks for the Same Owner

```shell
curl http://{{host}}:{{port}}/feedbacks?owner_id=1
```

### Execute Feedback Ex{port} Worker

To generate an XML file with all feedbacks:
```shell
bundle exec sidekiq -r ./lib/workers/feedback_ex{port}_worker.rb
```