drop table if exists day2input, day2part1, day2part2;
create table day2input (a char, b char);
\copy day2input from program 'cat $(git rev-parse --show-toplevel)/02/input.txt' delimiter ' ' csv;

create table day2part1 (a char, b char, score int);
insert into day2part1 (a, b, score) values ('A', 'X', 4), ('A', 'Y', 8), ('A', 'Z', 3), ('B', 'X', 1), ('B', 'Y', 5), ('B', 'Z', 9), ('C', 'X', 7), ('C', 'Y', 2), ('C', 'Z', 6);
select sum(score) "Part 1" from day2input join day2part1 using (a, b);

create table day2part2 (a char, b char, score int);
insert into day2part2 (a, b, score) values ('A', 'X', 3), ('A', 'Y', 4), ('A', 'Z', 8), ('B', 'X', 1), ('B', 'Y', 5), ('B', 'Z', 9), ('C', 'X', 2), ('C', 'Y', 6), ('C', 'Z', 7);
select sum(score) "Part 2" from day2input join day2part2 using (a, b);
