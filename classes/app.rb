# Import the modules needed to run the application
require 'json'
require_relative './book'
require_relative './student'
require_relative './teacher'
require_relative './person'
require_relative './rental'

# Create the app
# This is the main class of the application
# It will be responsible for the flow of the application
class App
  # Getters and setters
  attr_accessor :people, :books, :rented

  def initialize()
    @list = []
    @books = File.exist?('./books.json') ? JSON.parse(File.read('./books.json'), create_additions: true) : []
    @people = File.exist?('./people.json') ? JSON.parse(File.read('./people.json'), create_additions: true) : []
    @rented = File.exist?('./rentals.json') ? JSON.parse(File.read('./rentals.json'), create_additions: true) : []
  end

  # Select an option
  def select_option(option)
    case option
    when 1
      list_of_books(books)
    when 2
      list_of_people(people)
    when 3
      data = create_person
      @people << data
    when 4
      book = create_book
      @books << book
    when 5
      rental = create_rental(books, people)
      @rented << rental
    when 6
      list_of_rentals(rented)
    else
      puts 'invalid option'
    end
  end

  # Define the method to see the user interface
  def interface
    exit = 0
    print("          Welcome to School Library App! \n")
    while exit.zero?
      print("
          Please choose an option by entering a number: \n
          1 - List all books
          2 - List all people
          3 - Create a person
          4 - Create a book
          5 - Create a rental
          6 - List all rentals for a given person id
          7 - Exit \n
          ")
      option = gets.chomp.to_i
      option == 7 ? exit = 1 && save : select_option(option)
    end
    print "          Thanks for using the app! \n"
  end

  # Define the method to create a book, option 4
  def create_book()
    print "Insert title: \s"
    title = gets.chomp
    print "Insert author: \s"
    author = gets.chomp
    book = Book.new(title, author)
    print 'Book created succesfully'
    book
  end

  # Define the method to create a list of books, option 1
  def list_of_books(books)
    books.each_with_index do |book, index|
      puts "#{index}) Title: #{book.title} Author: #{book.author}"
    end
  end

  # Define the method to create a person, option 3
  def create_person
    print "Do you want to create a student (1) or a teacher (2)? [Input the number]:\s"
    value = gets.chomp
    case value
    when '1'
      data = create_student(value)
      student = Student.new(classroom: nil, age: data[:age], name: data[:name],
                            parent_permission: data[:permission])
      print 'Person created successfully'
      student
    when '2'
      data = create_teacher(value)
      teacher = Teacher.new(specialization: data[:specialization], age: data[:age], name: data[:name],
                            parent_permission: data[:permission])
      print 'Person created successfully'
      teacher
    else
      puts 'Invalid option'
    end
  end

  # Define the method to create a student, option 3.1
  def create_student(_value)
    print "Insert Age:\s"
    age = gets.chomp.to_i
    print "Insert Name:\s"
    name = gets.chomp
    print "Insert classroom:\s"
    classroom = gets.chomp
    print "Has parent permission [Y/N]?\s"
    permission = gets.chomp.capitalize
    permission = permission == 'Y'
    { age: age, name: name, classroom: classroom, permission: permission }
  end

  # Define the method to create a teacher, option 3.2
  def create_teacher(_value)
    print "Insert Age:\s"
    age = gets.chomp.to_i
    print "Insert Name:\s"
    name = gets.chomp
    print "Insert Specialization: \s"
    specialization = gets.chomp
    { age: age, name: name, specialization: specialization }
  end

  # Define the method to create a list of people, option 2
  def list_of_people(people)
    people.each_with_index do |person, index|
      puts "#{index}) [#{person.class.name}] Name: #{person.name} ID: #{person.id} Age: #{person.age}"
    end
  end

  # Define the method to create a rental, option 5
  def create_rental(books, people)
    print("Select by number one of the books listed (not id) \s\n")
    list_of_books(books)
    book_num = gets.chomp.to_i
    print("Select by number one of the people listed (not id) \s\n")
    list_of_people(people)
    person_num = gets.chomp.to_i
    print("Insert a date [DD-MM-YYYY]: \s")
    date = gets.chomp
    rental = Rental.new(date, people[person_num], books[book_num])
    print 'Rental created succesfully'
    rental
  end

  # Define the method to create a list of rentals, option 6
  def list_of_rentals(rentals)
    print("Insert person ID: \s")
    id = gets.chomp.to_i
    print("Rentals:\n")
    rented.map do |rental|
      puts "#{rental['date']}, ID: #{rental['person_id']} Book: \"#{rental['book']}\" " if rental['person_id'] == id
    end
  end

  def save
    File.write('./books.json', JSON.pretty_generate(@books))
    File.write('./people.json', JSON.pretty_generate(@people))
    File.write('./rentals.json', JSON.pretty_generate(@rented))
  end
end
