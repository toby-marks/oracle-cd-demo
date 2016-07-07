begin

    for i in (select * from all_users where username = 'LIBRARY') loop
        execute immediate 'drop user library cascade';
    end loop;
    
end;
/
