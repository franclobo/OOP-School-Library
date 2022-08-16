require 'json'
require_relative './person'

class Student < Person
  attr_accessor :classroom

  def initialize(age:, classroom:, name: 'Unknow', parent_permission: true)
    super(age: age, name: name, parent_permission: parent_permission)
    @classroom = classroom
  end

  def save
    self_json = [{age: @age, classroom: @classroom, name: @name, parent_permission: true}].to_json
    open('./store/people.json', 'a') do |file|
      file.puts self_json
    end
  end

  def play_hooky
    "¯\(ツ)/¯"
  end

  def classroom=(classroom)
    @classroom = classroom
    classroom.add_student(self) unless classroom.student.include?(self)
  end
end
