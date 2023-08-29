# Use the official Ruby image as the base image
FROM ruby:2.6

# Set environment variables
ENV APP_HOME /app
ENV BUNDLE_PATH /bundle

# Set the working directory
WORKDIR $APP_HOME

# Install system dependencies
RUN apt-get update -qq && apt-get install -y build-essential default-libmysqlclient-dev 

# Install bundler
RUN gem install bundler

# Copy the Gemfile and Gemfile.lock to the container
COPY Gemfile* $APP_HOME/

# Install project dependencies
RUN bundle install

# Copy the application code to the container
COPY . $APP_HOME/
