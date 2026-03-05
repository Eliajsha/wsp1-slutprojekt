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
end
