create or replace package library.books_api as

    type book_tbl is table of library.books%rowtype;
    type isbn_tbl is table of number;
    
    procedure add(p_books book_tbl);
    procedure del(p_isbns isbn_tbl);
    procedure upd(p_books book_tbl);
    
end;
/
show errors

create or replace package body library.books_api as

    procedure add(p_books book_tbl) is
    begin
        forall i in p_books.first..p_books.last
            insert into books values p_books(i);
    end;
    
    procedure del(p_isbns isbn_tbl) is
    begin
        forall i in p_isbns.first..p_isbns.last
            delete from books where book_isbn = p_isbns(i);
    end;
    
    procedure upd(p_books book_tbl) is
    begin
        forall i in p_books.first..p_books.last
            update books
            set 
                   book_title = p_books(i).book_title,
                   book_author = p_books(i).book_author,
                   book_pages = p_books(i).book_pages
            where 
                  (book_title  <> p_books(i).book_title or
                   book_author <> p_books(i).book_author or
                   book_pages  <> p_books(i).book_pages)
            and    
                   book_isbn   =  p_books(i).book_isbn;
    end;

end;
/
show errors

