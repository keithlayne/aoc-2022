\set QUIET 1
\timing off
SET client_min_messages TO WARNING;

drop schema if exists day02 cascade;
create schema day02;
set search_path to day02, public;

create table input (line text);
copy input from '/aoc/02/input.txt';

create table part1 (line text, score int);
insert into part1 (line, score) values 
  ('A X', 4), ('A Y', 8), ('A Z', 3), ('B X', 1), ('B Y', 5), ('B Z', 9), ('C X', 7), ('C Y', 2), ('C Z', 6);

create table part2 (line text, score int);
insert into part2 values 
  ('A X', 3), ('A Y', 4), ('A Z', 8), ('B X', 1), ('B Y', 5), ('B Z', 9), ('C X', 2), ('C Y', 6), ('C Z', 7);

\timing on
\unset QUIET

\echo Day 02
select sum(score) "Part 1" from input join part1 using (line);
select sum(score) "Part 2" from input join part2 using (line);