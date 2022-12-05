\set QUIET 1
\timing off
SET client_min_messages TO WARNING;

drop schema if exists day01 cascade;
create schema day01;
set search_path to day01, public;

create table input (line text);
copy input from '/aoc/01/input.txt';

\timing on
\unset QUIET

\echo
\echo Day 01

with data as (
  select calories, rank() over (order by calories desc) from (
    select sum(line::int) calories from (
      select line, count(1) filter (where line = '') over (rows unbounded preceding) grp from input
    ) grouped where line != '' group by grp
  ) ranked
) select (
    select max(calories) from data
  ) "Part 1", (
    select sum(calories) filter (where rank <= 3) from data
  ) "Part 2";
