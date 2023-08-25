Test for Ruby on Rails Developer at UMAI:


It is required to create a JSON API service in Ruby without using Ruby on Rails.
Entities:
1. User - has only an email and it must be present, unique, follow email regex.
2. The Post - it belongs to the user. Has a title, content, author's IP (saved separately for each post).
3. Rating - belongs to the post. Accepts a value from 1 to 5.


Actions:
1. Create a post. It should:
- [x] Accept the title and content of the post (cannot be empty), as well as the author's login and IP. - If there is no author with this username yet, it should be created.
- Return either post attributes with status 200 or errors validations with status 422.
2. Rate the post. It should:
- [x] Accept post ID and value.
- [x] Return a new one average post rating.
- [x] Important: the action must work correctly for any number of competitive requests to rate the same post.

3- [x] Get the top N posts by average rating. Just an array of objects with headings and content.
4. [x] Get a list of IPs from which several different authors posted. Array objects with fields: IP and an array of author logins.


Feedback has many posts and user, params: owner_id, comment (text)
5. Add feedback. It should:
- [x] Accept user_id or post_id, comment, owner_id
- [x] Return the existing feedback if found before.
- [x] Return feedback list form same owner ordered by latest

6. Add in seeds:
- [x] to generate 10k post feedback, and 50 user feedback with random text
- [x] Should be at least 200k posts in the database, it is better to make authors around 100 pieces, use 50 different IPs. Actions should work fast enough on standard hardware both for the specified
amount of data (faster than 100 ms), and for much more, that is, you need a good margin in terms of query optimization. To do this, you can use data denormalization and any other database tools.

7. [ ] Cover with specs main parts of your project
8. [x] Create a worker that will execute every day at 9 am and will generate an xml file with all feedbacks.
Should have an owner login, comment, rating (empty if user feedback), feedback type (post user).

 Advice:
- Avoid to use frameworks like a ROR, Sinatra, etc.
- Do not to use generators and generally do without unnecessary garbage files in the repository - You can use any necessary gem
- Organize the service architecture as you wish
- Testing assignment must be shared as an open link to git repo (on github, bitbucket, gitlab)
- Postman collection for your endpoints should be added to the root directory of your project
