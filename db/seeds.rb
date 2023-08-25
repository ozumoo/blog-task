require 'faker'

# ... User creation ...

# Create posts using bulk insert
posts = []
200_000.times do
  author = User.order('RANDOM()').first
  posts << {
    title: Faker::Lorem.sentence,
    content: Faker::Lorem.paragraphs(number: 3).join("\n"),
    author_ip: ips.sample,
    user_id: author.id
  }
end
Post.insert_all(posts)

# Create feedbacks for posts using bulk insert
feedbacks = []
10_000.times do
  post = Post.order('RANDOM()').first
  owner = User.order('RANDOM()').first
  feedbacks << {
    post_id: post.id,
    owner_id: owner.id,
    comment: Faker::Lorem.sentence
  }
end
Feedback.insert_all(feedbacks)

# Create feedbacks for users using bulk insert
user_feedbacks = []
50.times do
  user = User.order('RANDOM()').first
  owner = User.order('RANDOM()').first
  user_feedbacks << {
    user_id: user.id,
    owner_id: owner.id,
    comment: Faker::Lorem.sentence
  }
end
Feedback.insert_all(user_feedbacks)
