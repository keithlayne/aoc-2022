\set QUIET 1
\timing off
SET client_min_messages TO WARNING;

drop schema if exists day01 cascade;
create schema day01;
set search_path to day01, public;

drop table if exists input, data;
create table input (raw text);
copy input (raw) from program 'sed "/./{:a;N;s/\n\(.\)/ \1/;ta}" /aoc/01/input.txt' where raw != '';

\timing on
\unset QUIET

\echo
\echo Day 01

with data as (
  select (
    select sum(val::int) from regexp_split_to_table(raw,'\s+') val
  ) calories from input
),top3 as (
  select calories from data order by calories desc limit 3
) select (
    select max(calories) from data
  ) "Part 1", (
    select sum(calories) from top3
  ) "Part 2";
