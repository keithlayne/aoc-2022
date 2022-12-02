\set QUIET 1
\timing off
SET client_min_messages TO WARNING;

drop schema if exists day01 cascade;
create schema day01;
set search_path to day01, public;

drop table if exists input, data;
create table input (raw text);
\copy input (raw) from program 'sed "/./{:a;N;s/\n\(.\)/ \1/;ta}" $(git rev-parse --show-toplevel)/01/input.txt' where raw != '';
create table data as select (select sum(val::int) from regexp_split_to_table(raw,'\s+') val) calories from input;

\timing on
\unset QUIET

\echo Day 01
select max(calories) "Part 1" from data;
select sum(top3.calories) "Part 2" from (select calories from data order by calories desc limit 3) top3;
