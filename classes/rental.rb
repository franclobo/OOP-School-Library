class Rental
  attr_accessor :date, :person, :book

  def initialize(date, person, book)
    @date = date
    @person = person
    @book = book
    person.rentals << self
    book.rentals << self
  end

  def to_json(*arg)
    {
      JSON.create_id => self.class.name,
      'a' => [@date, @person.id, @book.title]
    }.to_json(*arg)
  end

  def self.json_create(object)
    {
      date: object['a'][0],
      person_id: object['a'][1],
      book_title: object['a'][2]
    }
  end
end
