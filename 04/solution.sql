\set QUIET 1
\timing off
SET client_min_messages TO WARNING;

drop schema if exists day04 cascade;
create schema day04;
set search_path to day04, public;

create table input (line text);
copy input from '/aoc/04/input.txt';

\timing on
\unset QUIET

\echo
\echo Day 04

with raw as (
  select regexp_match(line, '(\d+)-(\d+),(\d+)-(\d+)')::int[] m from input
), data (a, b) as (
  select int4range(m[1], m[2], '[]'), int4range(m[3], m[4], '[]') from raw
) select
    count(1) filter (where a @> b or a <@ b) "Part 1",
    count(1) filter (where a && b) "Part 2"
  from data;
