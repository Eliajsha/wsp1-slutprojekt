require 'sqlite3'

class Seeder

  def self.seed!
    p "doit"
  end

end

def self.drop_tables
  db.execute('DROP TABLE IF EXISTS recipes')
end

def self.create_tables
  db.execute('CREATE TABLE recipes (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              recipe_name TEXT NOT NULL,
              recipe TEXT NOT NULL,
              user_id INTEGER,
              category_id INTEGER)')
end

def self.populate_tables
  db.excecute('INSERT INTO recipes(recipe_name, recipe, user_id, category_id) VALUES (Pannkakor, baka på för fan)')
end