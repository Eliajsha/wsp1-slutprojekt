require 'debug'
require "awesome_print"
require 'sinatra'
require 'securerandom'


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

    configure do
      enable :sessions
      set :session_secret, SecureRandom.hex(64)
    end

    before do
      if session[:user_id]
        @current_user = db.execute("SELECT * FROM users WHERE id = ?", session[:user_id]).first
        ap @current_user
      end
    end

    # Routen / 
    get '/' do
        erb(:"recipes/index")
    end

    get '/recipes' do
      @recipes = db.execute("SELECT * FROM recipes")
      p @recipes
      erb(:"recipes/index")
    end

    get '/recipes/:id' do | id |
      @recipes = db.execute("SELECT * FROM recipes WHERE id=?", id).first
      erb(:"recipes/show")
    end

    get '/login' do 
      erb(:"users/login")
    end

    post '/login' do
      request_username = params[:username]
      request_plain_password = params[:password]
      
      user = db.execute("SELECT * FROM users WHERE username = ?", request_username).first

      unless user
        ap "/login : Invalid username."
        status 401
        redirect '/login'
      end

      db_id = user["id"].to_i
      db_password_hashed = user["password"].to_s

      bcrypt_db_password = BCrypt::Password.new(db_password_hashed)

      if bcrypt_db_password == request_plain_password
        ap "/login : Logged in -> redirecting to your recipes"
        session[:user_id] = db_id
        redirect "/user_recipes"
      else
        ap "/login : Invalid password."
        status 401
        redirect '/login'
      end
    end
end
