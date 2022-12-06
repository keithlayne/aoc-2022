\set QUIET 1
\timing off
SET client_min_messages TO WARNING;

drop schema if exists day03 cascade;
create schema day03;
set search_path to day03, public;

create table input (line text);
copy input from '/aoc/03/input.txt';

\timing on
\unset QUIET

\echo
\echo Day 03

with priorities as (
  select string_to_table('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', null) val,
  generate_series(1, 52) priority
), part1 as (
  select (
    select string_to_table(substr(line, 1, char_length(line)/2), null) val
    intersect
    select string_to_table(substr(line, char_length(line)/2 + 1), null) val
  ) from input
), groups as (
  select line, (row_number() over() - 1) / 3 grp from input
), arrays as (
  select array_agg(line) lines from groups group by grp
), part2 as (
  select (
    select string_to_table(lines[1], null) val
    intersect
    select string_to_table(lines[2], null) val
    intersect
    select string_to_table(lines[3], null) val
  ) from arrays
) select (
    select sum(priority) from part1 join priorities using (val)
  ) "Part 1", (
    select sum(priority) from part2 join priorities using (val)
  ) "Part 2";
