begin

    for i in (select * from dual where not exists (select * from all_users where username = 'LIBRARY')) loop
        execute immediate 'create user library identified by library';
        execute immediate 'grant connect, resource, unlimited tablespace to library';
    end loop;
    
end;
/
