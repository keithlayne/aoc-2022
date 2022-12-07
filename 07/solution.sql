\set QUIET 1
\timing off
SET client_min_messages TO WARNING;

drop schema if exists day07 cascade;
create schema day07;
set search_path to day07, public;

create table input (line text);
copy input from '/aoc/07/input.txt';

\timing on
\unset QUIET

\echo
\echo Day 07

with recursive entries (match, path) as (
  select
    regexp_match(line, '^(\d+) '),
    string_agg(replace(line, '$ cd ', ''), '/') filter (where line ^@ '$ cd') over (rows unbounded preceding)
  from input
), files_raw (size, path) as (
  select match[1]::int, path from entries where match is not null
  union
  select size, regexp_replace(path, '\/[^/]+\/\.\.', '') from files_raw
), files as (
  select * from files_raw where position('..' in path) = 0
), dirs (dir) as (
  select distinct path from files
  union
  select distinct regexp_replace(dir, '\/[^/]+$', '') from dirs
), sizes (total) as (
  select sum(size) from files join dirs on path ^@ dir group by dir
), threshold (minimum) as (
  select max(total) - 40000000 from sizes
) select
    sum(total) filter (where total <= 100000) "Part 1",
    min(total) filter (where total >= minimum) "Part 2"
  from sizes, threshold;
