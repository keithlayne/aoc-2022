\set QUIET 1
\timing off
SET client_min_messages TO WARNING;

drop schema if exists day08 cascade;
create schema day08;
set search_path to day08, public;

create table input (row serial, line text);
copy input (line) from '/aoc/08/input.txt';

create function score(trees int[], height int) returns int as $$
  select coalesce(
    (select i from generate_subscripts(trees, 1) i where trees[i] >= height limit 1),
    cardinality(trees)
  )
$$ language sql immutable;

\timing on
\unset QUIET

\echo
\echo Day 08 (with functions)

with grid (row, col, height) as (
  select row, generate_series(1, char_length(line)), string_to_table(line, null)::int from input
), views as (
  select
    height,
    coalesce(array_agg(height) over upward, array[]::int[]) u,
    coalesce(array_agg(height) over downward, array[]::int[]) d,
    coalesce(array_agg(height) over leftward, array[]::int[]) l,
    coalesce(array_agg(height) over rightward, array[]::int[]) r
  from grid
  window
    upward as (partition by col order by row desc rows between current row and unbounded following exclude current row),
    downward as (partition by col order by row rows between current row and unbounded following exclude current row),
    leftward as (partition by row order by col desc rows between current row and unbounded following exclude current row),
    rightward as (partition by row order by col rows between current row and unbounded following exclude current row)
) select
    count(1) filter (where height > all(u) or height > all(d) or height > all(l) or height > all(r)) "Part 1",
    max(score(u, height) * score(d, height) * score(l, height) * score(r, height)) "Part 2"
  from views;
