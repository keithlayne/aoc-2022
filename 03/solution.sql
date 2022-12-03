\set QUIET 1
\timing off
SET client_min_messages TO WARNING;

drop schema if exists day03 cascade;
create schema day03;
set search_path to day03, public;

create table input (line text);
copy input from '/aoc/03/input.txt';

create table priorities as (
  select string_to_table('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', null) val,
  generate_series(1, 52) priority
);

\timing on
\unset QUIET

\echo Day 03

with matches as (
  select (
    select string_to_table(substr(line, 1, char_length(line)/2), null) val
    intersect
    select string_to_table(substr(line, char_length(line)/2 + 1), null) val
  ) from input
) select sum(priority) "Part 1" from matches join priorities using (val);

with groups as (
  select line, ((row_number() over()) - 1) / 3 as grp from input
), arrays as (
  select array_agg(line) lines from groups group by grp
), matches as (
  select (
    select string_to_table(lines[1], null) val
    intersect
    select string_to_table(lines[2], null) val
    intersect
    select string_to_table(lines[3], null) val
  ) from arrays
) select sum(priority) "Part 2" from matches join priorities using (val);
