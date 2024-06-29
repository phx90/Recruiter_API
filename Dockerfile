# Dockerfile

# Use a imagem base do Ruby 2.7.2
FROM ruby:2.7.2

# Instala dependências do sistema
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia o Gemfile e o Gemfile.lock para o contêiner
COPY Gemfile Gemfile.lock ./

# Instala uma versão compatível do Bundler
RUN gem install bundler -v 2.4.22

# Instala gems com a versão específica do Bundler
RUN bundle install --jobs 20 --retry 5

# Copia o restante do código para o contêiner
COPY . .

RUN rails db:migrate

# Comando para iniciar a aplicação Rails
CMD ["rails", "server", "-b", "0.0.0.0"]
