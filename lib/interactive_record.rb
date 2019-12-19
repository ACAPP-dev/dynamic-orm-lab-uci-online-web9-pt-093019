require_relative "../config/environment.rb"
require 'active_support/inflector'

class InteractiveRecord
  def self.table_name
    self.to_s.downcase.pluralize
  end
  def self.column_names
    sql = "PRAGMA table_info(#{self.table_name})"
    array_of_hashes = DB[:conn].execute(sql)
    column_names = []
    array_of_hashes.each do |hash|
      column_names << hash["name"]
    end
    column_names
  end
  def initialize(attributes={})
    attributes.each do |key, value|
      self.send("#{key}=", value)
    end
  end
  def table_name_for_insert
    self.class.table_name
  end
  def col_names_for_insert
    #binding.pry
    self.class.column_names.delete_if do |column_name|
      column_name == "id"
    end.join(", ")
  end
  def values_for_insert
    binding.pry
  end
end
