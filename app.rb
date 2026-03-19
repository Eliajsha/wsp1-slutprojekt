require 'debug'
require "awesome_print"

class App < Sinatra::Base

    setup_development_features(self)

    # Funktion för att prata med databasen
    # Exempel på användning: db.execute('SELECT * FROM fruits')
    def db
      return @db if @db
      @db = SQLite3::Database.new(DB_PATH)
      @db.results_as_hash = true

      return @db
    end

    # Routen / 
    get '/' do
        erb(:"recipes/index")
    end

    get '/recipes' do
      @recipes = db.execute("SELECT * FROM recipes")
      p @recipes
      erb(:"main/index")
    end

    get '/recipes/:id' do | id |
      @recipes = db.execute("SELECT * FROM recipes WHERE id=?", id).first
      erb(:"main/show")
    end

    get '/login' do 
      erb(:"users/login")
    end

    post '/login' do
      request_username = params[:username]
      request_plain_password = params[:password]
      
      user = db.execute("SELECT * FROM users WHERE username=?", request_username).first
end
