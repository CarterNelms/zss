require 'sqlite3'

class Environment

  def self.environment=(environment)
    @@environment = environment
  end

  def self.database
    unless @database
      @database = SQLite3::Database.open("db/#{@@environment}.sqlite")
      @database.execute "CREATE TABLE IF NOT EXISTS training_paths(id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR(29))"
      @database.execute "CREATE TABLE IF NOT EXISTS skills(id INTEGER PRIMARY KEY AUTOINCREMENT, training_path_id INTEGER, name VARCHAR(29), description text, mastered text)"

      results = @database.execute "PRAGMA table_info(skills);"
      unless results.find{ |row| row[1] == 'description' }
        @database.execute "ALTER TABLE skills ADD COLUMN description text"
      end
    end
    @database
  end
end
