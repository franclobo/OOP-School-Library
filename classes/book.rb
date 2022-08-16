class Book
  attr_accessor :title, :author, :rentals

  def initialize(title, author)
    @title = title
    @author = author
    @rentals = []
  end

  def add_rental(date, person)
    rental = Rental.new(date, person, self)
    @rentals << rental unless @rentals.include?(rental)
  end

  def to_json(*arg)
    {
      JSON.create_id => self.class.name,
      'title' => title,
      'author' => author
    }.to_json(*arg)
  end

  def self.json_create(book)
    libro = new(book['title'], book['author'])
    libro
  end
end
