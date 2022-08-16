require 'json'
require_relative './person'

class Teacher < Person
  attr_accessor :specialization

  def initialize(age:, specialization:, name: 'Unknow', parent_permission: true)
    super(age: age, name: name, parent_permission: parent_permission)
    @specialization = specialization
  end

  def can_use_services?
    true
  end

  def save
    self_json = [{age: @age, specialization: @specialization, name: @name, parent_permission: true}].to_json
    open('./store/people.json', 'a') do |file|
      file.puts self_json
    end
  end
end
