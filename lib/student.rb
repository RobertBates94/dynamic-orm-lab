require_relative "../config/environment.rb"
require 'active_support/inflector'
require 'interactive_record.rb'

class Student < InteractiveRecord

    attr_accessor :name, :grade
    attr_reader :id

    def initialize(id = nil, name, grade)
        @id = id
        @name = name
        @grade = grade
    end

    def self.column_names(row)
        s.id = row[0]
        s.name = row[1]
        s.grade = row[2]

    end

end
