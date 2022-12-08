\set QUIET 1
\timing off
SET client_min_messages TO WARNING;

drop schema if exists day08 cascade;
create schema day08;
set search_path to day08, public;

create table input (row serial, line text);
copy input (line) from '/aoc/08/input.txt';

\timing on
\unset QUIET

\echo
\echo Day 08

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
), visible (trees) as (
  select count(1) filter (where height > all(u) or height > all(d) or height > all(l) or height > all(r)) from views
), scores (score) as (
  select max(
    coalesce((select i from generate_subscripts(u, 1) i where u[i] >= height limit 1), cardinality(u)) *
    coalesce((select i from generate_subscripts(l, 1) i where l[i] >= height limit 1), cardinality(l)) *
    coalesce((select i from generate_subscripts(r, 1) i where r[i] >= height limit 1), cardinality(r)) *
    coalesce((select i from generate_subscripts(d, 1) i where d[i] >= height limit 1), cardinality(d))
  )
  from views
) select trees "Part 1", score "Part 2" from visible, scores;
