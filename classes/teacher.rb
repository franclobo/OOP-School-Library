require_relative './person'

class Teacher < Person
  attr_accessor :specialization

  def initialize(specialization:, **parameters)
    super(**parameters)
    @specialization = specialization
  end

  def can_use_services?
    true
  end

  def to_json(*args)
    {
      JSON.create_id => self.class.name,
      'a' => [@specialization, @id, @name, @age, @parent_permission, @rentals]
    }.to_json(*args)
  end

  def self.json_create(object)
    teacher = new(specialization: object['a'][0], name: object['a'][2], age: object['a'][3],
                  parent_permission: object['a'][4])
    teacher.id = object['a'][1]
    teacher.rentals = object['a'][5]
    teacher
  end
end
