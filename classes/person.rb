require './nameable'
require './rental'

class Person < Nameable
  attr_accessor :age, :name, :rentals
  attr_reader :id

  def initialize(age, name = 'Unknow', parent_permission: true)
    super()
    @id = Random.rand(1..100)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  def correct_name
    @name
  end

  private

  def of_age?
    @age >= 18
  end

  def add_rental(date, book)
    Rental.new(date, self, book)
  end
end
