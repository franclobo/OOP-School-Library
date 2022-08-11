class Person
  attr_accessor :age, :name, :id, :parent_permission

  def initialize(age:, name: 'Unknow', parent_permission: true)
    super()
    @id = Random.rand(1..100)
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  def can_use_services?
    is_of_age? || @parent_permission
  end

  private

  def of_age?
    @age >= 18
  end
end
