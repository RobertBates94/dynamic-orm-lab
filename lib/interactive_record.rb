require_relative "../config/environment.rb"
require 'active_support/inflector'
require "pry" 

class InteractiveRecord

    def self.table_name
        "#{self.to_s.downcase}s"
    end

    def self.create_table
        sql = <<-SQL
        CREATE TABLE IF NOT EXISTS #{self.table_name} (
            id INTEGER PRIMARY KEY,
            name TEXT,
            grade INTEGER
        )
        SQL
        
        DB[:conn].execute(sql)
    end

    def self.find(id)
        sql = <<-SQL
        SELECT * FROM #{self.table_name} WHERE id = ?
        SQL

        rows = DB[:conn].execute(sql, id)
        self.reify_from_row(row.first)
    end

    def self.reify_from_row(row)
        self.new.map do |s|
            s.id = row[0]
            s.name = row[1]
            s.grade = row[2]
        end
    end

    def insert
        sql = <<-SQL
            INSERT INTO #(self.table_name) (name, grade)
            VALUES (?, ?)
        SQL

        DB[:conn].execute(sql, self.name, self.grade)
        self.id = DB[:conn].execute("SELECT last_insert_rowid();").flatten.first
    end

    def update
        sql = <<-SQL
        UPDATE #{self.table_name} SET name = ?, grade = ?, WHERE id = ?
        SQL

        DB[:conn].execute(sql, self.name, self.grade, self.id)
    end

    def save
    end

    def self.column_names
        sql = <<-SQL
        CREATE TABLE IF NOT EXISTS #{self.table_name} (
            id INTEGER PRIMARY KEY,
            name TEXT,
            grade INTEGER
        )
        SQL
        table_info = DB[:conn].execute(sql)
        column_names = []

        table_info.map do |row|
            column_names << row["name"]
        end
    end

  
end
