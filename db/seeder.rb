require 'sqlite3'
require_relative '../config'
require 'bcrypt'



class Seeder

    def self.seed!
      puts "Using db file: #{DB_PATH}"
      puts "🧹 Dropping old tables..."
      drop_tables
      puts "🧱 Creating tables..."
      create_tables
      puts "🍎 Populating tables..."
      populate_tables
      puts "✅ Done seeding the database!"
    end


  def self.drop_tables
    db.execute('DROP TABLE IF EXISTS recipes')
    db.execute('DROP TABLE IF EXISTS users')
    db.execute('DROP TABLE IF EXISTS user_recipes')
  end

  def self.create_tables
    db.execute('CREATE TABLE recipes (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                recipe_name TEXT NOT NULL,
                description TEXT NOT NULL,
                category TEXT NOT NULL,
                rating TEXT NOT NULL)')

    db.execute('CREATE TABLE users (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                username TEXT NOT NULL,
                password TEXT NOT NULL)')

    db.execute('CREATE TABLE user_recipes (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                user_id INTEGER,
                recipe_id INTEGER)')
    
  end

  def self.populate_tables
    db.execute('INSERT INTO recipes(recipe_name, description, category, rating) VALUES ("Pannkakor", "baka på för fan", "vegetariskt", "4")')
    db.execute('INSERT INTO recipes(recipe_name, description, category, rating) VALUES ("Köttbullar med potatismos", "Du köttar köttet till en boll o sen lagar köttet till en köttbull o drämmer på potätmos med brunsås", "Animaliskt", "5")')
    db.execute('INSERT INTO recipes(recipe_name, description, category, rating) VALUES ("Cesarsallad", "Blanda ihop lite grönsaker och en fet kyckling med sös o dammish", "Animaliskt", "3")')
    db.execute('INSERT INTO recipes(recipe_name, description, category, rating) VALUES ("Grönsakswok", "Stek upp lite grönsaker och servera med ris", "Vegetariskt", "2")')
    db.execute('INSERT INTO recipes(recipe_name, description, category, rating) VALUES ("Lasagne", "Varva köttfärssås och bechamelsås och ost och pasta och sen in i ugnen", "Animaliskt", "4")')
    db.execute('INSERT INTO recipes(recipe_name, description, category, rating) VALUES ("Falafel", "Mixa ihop lite kikärtor och kryddor och gör bollar av det och fritera", "Vegetariskt", "1")')
    db.execute('INSERT INTO recipes(recipe_name, description, category, rating) VALUES ("Sushi", "Rulla ihop lite ris och fisk och grönsaker i ett noriark", "Animaliskt", "5")')
    db.execute('INSERT INTO recipes(recipe_name, description, category, rating) VALUES ("Vegetarisk lasagne", "Varva grönsaksfärssås och bechamelsås och ost och pasta och sen in i ugnen", "Vegetariskt", "4")')
    db.execute('INSERT INTO recipes(recipe_name, description, category, rating) VALUES ("Grönsaksgryta", "Koka ihop lite grönsaker i en god buljong", "Veganskt", "3")')
  
    db.execute('INSERT INTO user_recipes(user_id, recipe_id) VALUES (1, 1)')

    password_hashed = BCrypt::Password.create("123")
    p "Storing hashed password (#{password_hashed}) to DB. Clear text password (123) never saved"
    db.execute('INSERT INTO users(username, password) VALUES (?, ?)', ["Elias", password_hashed])

  end

  private

  def self.db
    @db ||= begin
      db = SQLite3::Database.new(DB_PATH)
      db.results_as_hash = true
      db
    end
  end

end

Seeder.seed!