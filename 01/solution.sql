drop table if exists day1input, day1data;
create table day1input (raw text);
\copy day1input (raw) from program 'sed "/./{:a;N;s/\n\(.\)/ \1/;ta}" input.txt' where raw != '';
create table day1data as select (select sum(val::int) from regexp_split_to_table(raw,'\s+') val) calories from day1input;

select max(calories) "Part 1" from day1data;
select sum(top3.calories) "Part 2" from (select calories from day1data order by calories desc limit 3) top3;
