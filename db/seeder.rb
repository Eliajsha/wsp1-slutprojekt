require 'sqlite3'
require_relative '../config'

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
              category TEXT NOT NULL)')
end

def self.populate_tables
  db.execute('INSERT INTO recipes(recipe_name, description, user_id, category) VALUES ("Pannkakor", "baka på för fan", 2, "vegetariskt")')
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