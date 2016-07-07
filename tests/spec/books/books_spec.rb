describe "Books" do
  
  include BookFactory
  
  c = 0
  
  [ [ 9780060653378, 'Hostage to the Devil',             'Martin, Malachi', 364],
    [ 9780671657161, 'The Jesuits',                      'Martin, Malachi', 743],
    [ 9780385492317, 'Windswept House: A Vatican Novel', 'Martin, Malachi', 566]
  ].each do | book_isbn, book_title, book_author, book_pages|
    it "should correctly insert book records" do
      book = create_book(
        :book_isbn   => book_isbn,
        :book_title  => book_title,
        :book_author => book_author,
        :book_pages  => book_pages
      )
      c+=1
      expect(plsql.books.count).to eq c
    end
  end
  
  it "should raise ORA-01400 if isbn is missing" do
    book_isbn, book_title, book_author = nil, 'The Jesuits', 'Malachi Martin'
    expect {
      book = create_book(
        :book_isbn   => book_isbn,
        :book_title  => book_title,
        :book_author => book_author,
        :book_pages  => 743
      )
    }.to raise_error(/ORA-01400/)
  end

  it "should raise ORA-01400 if author is missing" do
    book_isbn, book_title, book_author = 9780671657161, 'The Jesuits', nil
    expect {
      book = create_book(
        :book_isbn   => book_isbn,
        :book_title  => book_title,
        :book_author => book_author,
        :book_pages  => 743
      )
    }.to raise_error(/ORA-01400/)
  end

  it "should raise ORA-01400 if title is missing" do
    book_isbn, book_title, book_author = 9780671657161, nil, 'Malachi Martin'
    expect {
      book = create_book(
        :book_isbn   => book_isbn,
        :book_title  => book_title,
        :book_author => book_author,
        :book_pages  => 743
      )
    }.to raise_error(/ORA-01400/)
  end

end
