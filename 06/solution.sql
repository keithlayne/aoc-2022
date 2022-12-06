\set QUIET 1
\timing off
SET client_min_messages TO WARNING;

drop schema if exists day06 cascade;
create schema day06;
set search_path to day06, public;

create table input (num serial, line text);
copy input (line) from '/aoc/06/input.txt';

\timing on
\unset QUIET

\echo
\echo Day 06

with data (c, pos) as (
  select string_to_table(line, null), generate_series(1, char_length(line)) from input
), part1 (pos, cnt) as (
  select pos, (select count(distinct c) from unnest(chars) c) from (
    select pos, array_agg(c) over (rows 3 preceding) chars from data
  ) w
), part2 (pos, cnt) as (
  select pos, (select count(distinct c) from unnest(chars) c) from (
    select pos, array_agg(c) over (rows 13 preceding) chars from data
  ) w
) select (
    select pos from part1 where cnt = 4 limit 1
  ) "Part 1", (
    select pos from part2 where cnt = 14 limit 1
  ) "Part 2";
