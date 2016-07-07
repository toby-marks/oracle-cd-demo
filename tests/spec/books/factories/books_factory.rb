module BookFactory

  # Creates a new book with valid field values.
  # Pass in parameters only field values that you want to override.
  def create_book(params)
    book = {
      :book_isbn => nil,
      :book_title => nil,
      :book_author => nil,
      :book_pages => nil
    }.merge(params)
    plsql.books.insert book
    get_book book[:book_isbn]
  end

  # Select books by unique key
  def get_book(book_isbn)
    plsql.books.first :book_isbn => book_isbn
  end

end