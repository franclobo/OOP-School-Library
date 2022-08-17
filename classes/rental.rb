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
      'date' => @date,
      'person' => @person.id,
      'book' => @book.title
    }.to_json(*arg)
  end

  def self.json_create(rental)
    {
      date: rental['date'],
      person_id: rental['person'],
      book: rental['book']
    }
  end
end
