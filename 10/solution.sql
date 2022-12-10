\set QUIET 1
\timing off
SET client_min_messages TO WARNING;

drop schema if exists day10 cascade;
create schema day10;
set search_path to day10, public;

create table input (num serial, line text);
copy input (line) from '/aoc/10/input.txt';

\timing on
\unset QUIET

\echo
\echo Day 10

with recursive matches (m) as (
  select regexp_match(line, '^\w+( .*)?')::int[] from input
), deltas (cycle, delta) as (
  select row_number() over ()::int, dx
  from matches, unnest(case when m[1] is null then array[0] else array[0, m[1]] end) dx
), cycles (cycle, x, c, r) as (
  select 1, 1, 0, 0
  union
  select cycle + 1, x + delta, cycle % 40, cycle / 40
  from cycles join deltas using (cycle) where cycle < 240
), part1 ("Part1") as (
  select sum(cycle * x) filter (where (cycle - 20) % 40 = 0) from cycles
), part2 ("Part2") as (
  select string_agg(case when c between x - 1 and x + 1 then '#' else '.' end, '')
  from cycles group by r order by r
) select * from part1, part2;
