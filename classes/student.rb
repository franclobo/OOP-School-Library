require "./person.rb"

class Student < Person
  attr_reader :classroom

  def initialize(name: "Unknow", age:, parent_permission: true, classroom)
    super(name, age, parent_permission: parent_permission)
  end

  def play_hooky
    "¯\(ツ)/¯"
  end
end
