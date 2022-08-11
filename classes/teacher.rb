require "./person.rb"

class Teacher < Person
  attr_accessor :specialization

  def initialize(name: "Unknow", age, specialization)
    super(name, age)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end
