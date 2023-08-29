# JSON API Service Documentation

This documentation outlines the JSON API service built to handle users, posts, ratings, and feedbacks based on the specified requirements in `task.md` defention . The service is built using Ruby and utilizes the ActiveRecord framework for database operations. The API endpoints can be interacted with using CURL commands.

## Installation

1. Clone the repository:
   ```
   git clone https://github.com/yourusername/yourproject.git
   ```

2. Navigate to the project directory:
   ```
   cd yourproject
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

## API Endpoints

### Create User

```shell
curl -X POST http://localhost:4567/users -d "email=user@example.com"
```

### Create Post

```shell
curl -X POST http://localhost:4567/posts -d "title=Post Title" -d "content=Post Content" -d "author_login=author@example.com" -d "author_ip=127.0.0.1"
```

### Rate Post

```shell
curl -X POST http://localhost:4567/ratings -d "post_id=1" -d "value=4"
```

### Get Top N Posts by Average Rating

```shell
curl http://localhost:4567/posts/top_rated?n=5
```

### Get IPs and Author Logins

```shell
curl http://localhost:4567/posts/author_ips
```

### Add Feedback

```shell
curl -X POST http://localhost:4567/feedbacks -d "user_id=1" -d "post_id=1" -d "comment=Great post!"
```

### Get Feedbacks for the Same Owner

```shell
curl http://localhost:4567/feedbacks?owner_id=1
```

### Execute Feedback Export Worker

To generate an XML file with all feedbacks:
```shell
bundle exec sidekiq -r ./lib/workers/feedback_export_worker.rb
```

## Conclusion

This JSON API service provides endpoints to manage users, posts, ratings, and feedbacks as per the specified requirements. You can use the provided CURL commands to interact with the API and perform various actions.

---

Please note that this is a general template for the technical documentation, and you should customize it based on your actual project structure and requirements. Make sure to provide accurate and detailed information to help users understand how to install, use, and interact with your API service.