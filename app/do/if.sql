set term off
col do_next new_val do_next noprint
select
     case 
         when &1 then 'do/null'
         else 'do/comment_on'
     end as do_next
from dual;
set term on
@&do_next
