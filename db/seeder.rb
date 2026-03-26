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
  end

  def self.create_tables
    db.execute('CREATE TABLE recipes (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                recipe_name TEXT NOT NULL,
                description TEXT NOT NULL,
                user_id INTEGER,
                category TEXT NOT NULL,
                rating TEXT NOT NULL)')
  end

  def self.populate_tables
    db.execute('INSERT INTO recipes(recipe_name, description, user_id, category, rating) VALUES ("Pannkakor", "baka på för fan", 2, "vegetariskt", "★★★★☆")')
    db.execute('INSERT INTO recipes(recipe_name, description, user_id, category, rating) VALUES ("Köttbullar med potatismos", "Du köttar köttet till en boll o sen lagar köttet till en köttbull o drämmer på potätmos med brunsås", 1, "Animaliskt", "★★★★★")')
    db.execute('INSERT INTO recipes(recipe_name, description, user_id, category, rating) VALUES ("Cesarsallad", "Blanda ihop lite grönsaker och en fet kyckling med sös o dammish", 1, "Animaliskt", "★★★☆☆")')
    db.execute('INSERT INTO recipes(recipe_name, description, user_id, category, rating) VALUES ("Grönsakswok", "Stek upp lite grönsaker och servera med ris", 2, "Vegetariskt", "★★☆☆☆")')
    db.execute('INSERT INTO recipes(recipe_name, description, user_id, category, rating) VALUES ("Lasagne", "Varva köttfärssås och bechamelsås och ost och pasta och sen in i ugnen", 1, "Animaliskt", "★★★★☆")')
    db.execute('INSERT INTO recipes(recipe_name, description, user_id, category, rating) VALUES ("Falafel", "Mixa ihop lite kikärtor och kryddor och gör bollar av det och fritera", 2, "Vegetariskt", "★☆☆☆☆")')
    db.execute('INSERT INTO recipes(recipe_name, description, user_id, category, rating) VALUES ("Sushi", "Rulla ihop lite ris och fisk och grönsaker i ett noriark", 4, "Animaliskt", "★★★★★")')
    db.execute('INSERT INTO recipes(recipe_name, description, user_id, category, rating) VALUES ("Vegetarisk lasagne", "Varva grönsaksfärssås och bechamelsås och ost och pasta och sen in i ugnen", 2, "Vegetariskt", "★★★★☆")')
    db.execute('INSERT INTO recipes(recipe_name, description, user_id, category, rating) VALUES ("Grönsaksgryta", "Koka ihop lite grönsaker i en god buljong", 4, "Veganskt", "★★★☆☆")')
  end

  private

  def self.db
    @db ||= begin
      db = SQLite3::Database.new(DB_PATH)
      db.results_as_hash = true
      db
    end
  end

  def self.drop_tables
    db.execute('DROP TABLE IF EXISTS users')
  end

  def self.create_tables
    db.execute('CREATE TABLE users (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                username TEXT NOT NULL,
                password TEXT NOT NULL)')
  end

  def self.populate_tables
    password_hashed = BCrypt::Password.create("123")
    p "Storing hashed password (#{password_hashed}) to DB. Clear text password (123) never saved"
    db.execute('INSERT INTO users(username, password) VALUES (?, ?)', ["Elias", password_hashed])
  end
end

Seeder.seed!