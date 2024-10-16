# Dockerfile
FROM ruby:3.1.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y postgresql-client
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs
RUN npm install -g yarn@1.21.1

WORKDIR /app

# Install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install --without development test

# Install JavaScript dependencies
COPY package.json yarn.lock ./
RUN yarn install --check-files

# Copy the main application
COPY . ./

# Copy the .env file
COPY .env /app/.env

# Set environment variables
ENV $(cat /app/.env | xargs)

# Precompile assets
RUN SECRET_KEY_BASE=$(grep SECRET_KEY_BASE /app/.env | cut -d '=' -f2) \
    RAILS_ENV=production \
    bundle exec rails assets:precompile

# Add a script to be executed every time the container starts
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
