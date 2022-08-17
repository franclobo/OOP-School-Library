require_relative './person'

class Student < Person
  attr_accessor :classroom

  def initialize(classroom:, **parameters)
    super(**parameters)
    @classroom = classroom
  end

  def to_json(*args)
    {
      JSON.create_id => self.class.name,
      'a' => [@classroom, @id, @name, @age, @parent_permission, @rentals]
    }.to_json(*args)
  end

  def self.json_create(object)
    student = new(classroom: object['a'][0], name: object['a'][2], age: object['a'][3],
                  parent_permission: object['a'][4])
    student.id = object['a'][1]
    student.rentals = object['a'][5]
    student
  end
end
