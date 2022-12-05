\set QUIET 1
\timing off
SET client_min_messages TO WARNING;

drop schema if exists day05 cascade;
create schema day05;
set search_path to day05, public;

create table input (num serial, line text);
copy input (line) from '/aoc/05/input.txt';

\timing on
\unset QUIET

\echo
\echo Day 05

with recursive moves_raw as (
  select num, regexp_match(line, '(\d+).*(\d+).*(\d+)')::int[] m
  from input where regexp_like(line, 'move (\d+) from (\d+) to (\d+)')
), moves (move, cnt, src, dest) as (
  select num, m[1], m[2], m[3] from moves_raw
), stacks_raw as (
  select num, generate_series(1, 100) col, string_to_table(line, null) crate
  from input where regexp_like(line, '[A-Z]')
), stacks (crates, stack) as (
  select string_agg(crate, '' order by num desc), ((col - 2) / 4) + 1
  from stacks_raw where regexp_like(crate, '[A-Z]') group by col
), part1 (move, crates) as (
  select (select min(move) from moves), array_agg(crates order by stack) from stacks
  union
  select move + 1, array(
    select case
      when i = src then left(crates[i], -cnt)
      when i = dest then crates[i] || reverse(right(crates[src], cnt))
      else crates[i]
    end
    from generate_subscripts(crates, 1) as s (i)
  )
  from part1 join moves using (move)
), part2 (move, crates) as (
  select (select min(move) from moves), array_agg(crates order by stack) from stacks
  union
  select move + 1, array(
    select case
      when i = src then left(crates[i], -cnt)
      when i = dest then crates[i] || right(crates[src], cnt)
      else crates[i]
    end
    from generate_subscripts(crates, 1) as s (i)
  )
  from part2 join moves using (move)
)
select (
  select (
    select string_agg(right(c, 1), '') from unnest(crates) c
  ) from part1 order by move desc limit 1
) "Part 1", (
  select (
    select string_agg(right(c, 1), '') from unnest(crates) c
  ) from part2 order by move desc limit 1
) "Part 2";
