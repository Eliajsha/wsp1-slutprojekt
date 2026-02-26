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
        erb(:"main/index")
    end

    get '/recepies' do
      @recepies = db.execute("SELECT * FROM recepies")
      p @recepies
      erb(:"recepies/index")
    end

    get '/recepies/:id' do | id |
      @recepies = db.execute("SELECT * FROM recepies WHERE id=?", id).first
      erb(:"recepies/show")
    end
end
