begin

    for i in (select * from dual where not exists (select * from all_tables where owner = 'LIBRARY' and table_name = 'BOOKS')) loop

        execute immediate '
            create table library.books (
                book_seq_nbr   number           generated by default on null as identity (start with 1 increment by 1 cache 100),
                book_isbn      number           not null,
                book_title     varchar2(4000)   not null,
                book_author    varchar2(1000)   not null,
                book_pages     number
            )
        ';

    end loop;
    
    for i in (select * from dual where not exists (select * from all_indexes where owner = 'LIBRARY' and index_name = 'BOOKS_U1')) loop

        execute immediate '
            create unique index library.books_u1 on library.books(book_isbn)
        ';
        
    end loop;
    
end;
/