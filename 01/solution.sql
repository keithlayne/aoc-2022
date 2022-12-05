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

with grouped as (
  select line, count(1) filter (where line = '') over (rows unbounded preceding) grp from input
), summed as (
  select sum(line::int) calories from grouped where line != '' group by grp
), ranked as (
  select calories, rank() over (order by calories desc) from summed
) select (
    select max(calories) from summed
  ) "Part 1", (
    select sum(calories) filter (where rank <= 3) from ranked
  ) "Part 2";
