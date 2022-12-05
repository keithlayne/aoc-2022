\set QUIET 1
\timing off
SET client_min_messages TO WARNING;

drop schema if exists day04 cascade;
create schema day04;
set search_path to day04, public;

create table input (a int4range, b int4range);
copy input from program 'sed -r "s/,/|/;s/([0-9]+)-([0-9]+)/[\1,\2]/g" /aoc/04/input.txt' delimiter '|' csv;

\timing on
\unset QUIET

\echo
\echo Day 04

select (
    select count(1) from input where a @> b or a <@ b
  ) "Part 1", (
    select count(1) from input where a && b
  ) "Part 2";
