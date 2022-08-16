require 'json'
require_relative './person'

class Student < Person
  attr_accessor :classroom

  def initialize(age:, classroom:, name: 'Unknow', parent_permission: true)
    super(age: age, name: name, parent_permission: parent_permission)
    @classroom = classroom
  end

  def to_json(*args)
    {
      JSON.create_id => self.class.name,
      'age' => age,
      'classroom' => classroom,
      'name' => name,
      'parent_permission' => @parent_permission,
      'id' => id
    }.to_json(*args)
  end

  def self.json_create(student)
    person = new(student['age'], student['specialization'], student['name'], student['parent_permission'])
    person.id = student['id']
    person
  end

  def play_hooky
    "¯\(ツ)/¯"
  end

  def classroom=(classroom)
    @classroom = classroom
    classroom.add_student(self) unless classroom.student.include?(self)
  end
end
