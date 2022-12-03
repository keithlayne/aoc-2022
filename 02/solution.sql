\set QUIET 1
\timing off
SET client_min_messages TO WARNING;

drop schema if exists day02 cascade;
create schema day02;
set search_path to day02, public;

create table input (line text);
copy input from '/aoc/02/input.txt';

\timing on
\unset QUIET

\echo
\echo Day 02

with part1 (line, score) as (
  values ('A X', 4), ('A Y', 8), ('A Z', 3),
         ('B X', 1), ('B Y', 5), ('B Z', 9),
         ('C X', 7), ('C Y', 2), ('C Z', 6)
), part2 (line, score) as (
  values ('A X', 3), ('A Y', 4), ('A Z', 8),
         ('B X', 1), ('B Y', 5), ('B Z', 9),
         ('C X', 2), ('C Y', 6), ('C Z', 7)
) select (
    select sum(score) from input join part1 using (line)
  ) "Part 1", (
    select sum(score) from input join part2 using (line)
  ) "Part 2";
