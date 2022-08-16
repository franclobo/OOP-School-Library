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

  def to_json(*args)
    {
      JSON.create_id => self.class.name,
      'age' => age,
      'specialization' => specialization,
      'name' => name,
      'parent_permission' => @parent_permission,
      'id' => id
    }.to_json(*args)
  end

  def self.json_create(teacher)
    person = new(teacher['age'], teacher['specialization'], teacher['name'], teacher['parent_permission'])
    person.id = teacher['id']
    person
  end
end
