\set QUIET 1
\timing off
SET client_min_messages TO WARNING;

drop schema if exists day09 cascade;
create schema day09;
set search_path to day09, public;

create table input (line text);
copy input from '/aoc/09/input.txt';

create table deltas (step serial primary key, dx int, dy int);

insert into deltas (dx, dy)
with matches (m) as (
  select regexp_match(line, '^(\w) (\d+)$') from input
)
select
  case m[1] when 'L' then -1 when 'R' then 1 else 0 end,
  case m[1] when 'D' then -1 when 'U' then 1 else 0 end
from matches, generate_series(1, m[2]::int);

create table knots (step int, x int, y int, knot int, primary key (step, knot));

insert into knots
with recursive pos (step, x, y) as (
  select 1, 0, 0
  union
  select step + 1, x + dx, y + dy from pos join deltas using (step)
) select *, 1 from pos;

insert into knots
with recursive pos (step, x, y) as (
  select 1, 0, 0
  union
  select
    step + 1,
    case
      when abs(h.x - t.x) <= 1 and abs(h.y - t.y) <= 1 then t.x
      when h.y = t.y and h.x = t.x + 2 then t.x + 1
      when h.y = t.y and h.x = t.x - 2 then t.x - 1
      when h.x > t.x  and h.y != t.y then t.x + 1
      when h.x < t.x and h.y != t.y then t.x - 1
      else t.x
    end,
    case
      when abs(h.x - t.x) <= 1 and abs(h.y - t.y) <= 1 then t.y
      when h.x = t.x and h.y = t.y + 2 then t.y + 1
      when h.x = t.x and h.y = t.y - 2 then t.y - 1
      when h.x != t.x and h.y > t.y then t.y + 1
      when h.x != t.x and h.y < t.y then t.y - 1
      else t.y
    end
  from pos t join knots h using (step) where knot = 1
) select *, 2 knot from pos;

insert into knots
with recursive pos (step, x, y) as (
  select 1, 0, 0
  union
  select
    step + 1,
    case
      when abs(h.x - t.x) <= 1 and abs(h.y - t.y) <= 1 then t.x
      when h.y = t.y and h.x = t.x + 2 then t.x + 1
      when h.y = t.y and h.x = t.x - 2 then t.x - 1
      when h.x > t.x  and h.y != t.y then t.x + 1
      when h.x < t.x and h.y != t.y then t.x - 1
      else t.x
    end,
    case
      when abs(h.x - t.x) <= 1 and abs(h.y - t.y) <= 1 then t.y
      when h.x = t.x and h.y = t.y + 2 then t.y + 1
      when h.x = t.x and h.y = t.y - 2 then t.y - 1
      when h.x != t.x and h.y > t.y then t.y + 1
      when h.x != t.x and h.y < t.y then t.y - 1
      else t.y
    end
  from pos t join knots h using (step) where knot = 2
) select *, 3 knot from pos;

insert into knots
with recursive pos (step, x, y) as (
  select 1, 0, 0
  union
  select
    step + 1,
    case
      when abs(h.x - t.x) <= 1 and abs(h.y - t.y) <= 1 then t.x
      when h.y = t.y and h.x = t.x + 2 then t.x + 1
      when h.y = t.y and h.x = t.x - 2 then t.x - 1
      when h.x > t.x  and h.y != t.y then t.x + 1
      when h.x < t.x and h.y != t.y then t.x - 1
      else t.x
    end,
    case
      when abs(h.x - t.x) <= 1 and abs(h.y - t.y) <= 1 then t.y
      when h.x = t.x and h.y = t.y + 2 then t.y + 1
      when h.x = t.x and h.y = t.y - 2 then t.y - 1
      when h.x != t.x and h.y > t.y then t.y + 1
      when h.x != t.x and h.y < t.y then t.y - 1
      else t.y
    end
  from pos t join knots h using (step) where knot = 3
) select *, 4 knot from pos;

insert into knots
with recursive pos (step, x, y) as (
  select 1, 0, 0
  union
  select
    step + 1,
    case
      when abs(h.x - t.x) <= 1 and abs(h.y - t.y) <= 1 then t.x
      when h.y = t.y and h.x = t.x + 2 then t.x + 1
      when h.y = t.y and h.x = t.x - 2 then t.x - 1
      when h.x > t.x  and h.y != t.y then t.x + 1
      when h.x < t.x and h.y != t.y then t.x - 1
      else t.x
    end,
    case
      when abs(h.x - t.x) <= 1 and abs(h.y - t.y) <= 1 then t.y
      when h.x = t.x and h.y = t.y + 2 then t.y + 1
      when h.x = t.x and h.y = t.y - 2 then t.y - 1
      when h.x != t.x and h.y > t.y then t.y + 1
      when h.x != t.x and h.y < t.y then t.y - 1
      else t.y
    end
  from pos t join knots h using (step) where knot = 4
) select *, 5 knot from pos;

insert into knots
with recursive pos (step, x, y) as (
  select 1, 0, 0
  union
  select
    step + 1,
    case
      when abs(h.x - t.x) <= 1 and abs(h.y - t.y) <= 1 then t.x
      when h.y = t.y and h.x = t.x + 2 then t.x + 1
      when h.y = t.y and h.x = t.x - 2 then t.x - 1
      when h.x > t.x  and h.y != t.y then t.x + 1
      when h.x < t.x and h.y != t.y then t.x - 1
      else t.x
    end,
    case
      when abs(h.x - t.x) <= 1 and abs(h.y - t.y) <= 1 then t.y
      when h.x = t.x and h.y = t.y + 2 then t.y + 1
      when h.x = t.x and h.y = t.y - 2 then t.y - 1
      when h.x != t.x and h.y > t.y then t.y + 1
      when h.x != t.x and h.y < t.y then t.y - 1
      else t.y
    end
  from pos t join knots h using (step) where knot = 5
) select *, 6 knot from pos;

insert into knots
with recursive pos (step, x, y) as (
  select 1, 0, 0
  union
  select
    step + 1,
    case
      when abs(h.x - t.x) <= 1 and abs(h.y - t.y) <= 1 then t.x
      when h.y = t.y and h.x = t.x + 2 then t.x + 1
      when h.y = t.y and h.x = t.x - 2 then t.x - 1
      when h.x > t.x  and h.y != t.y then t.x + 1
      when h.x < t.x and h.y != t.y then t.x - 1
      else t.x
    end,
    case
      when abs(h.x - t.x) <= 1 and abs(h.y - t.y) <= 1 then t.y
      when h.x = t.x and h.y = t.y + 2 then t.y + 1
      when h.x = t.x and h.y = t.y - 2 then t.y - 1
      when h.x != t.x and h.y > t.y then t.y + 1
      when h.x != t.x and h.y < t.y then t.y - 1
      else t.y
    end
  from pos t join knots h using (step) where knot = 6
) select *, 7 knot from pos;

insert into knots
with recursive pos (step, x, y) as (
  select 1, 0, 0
  union
  select
    step + 1,
    case
      when abs(h.x - t.x) <= 1 and abs(h.y - t.y) <= 1 then t.x
      when h.y = t.y and h.x = t.x + 2 then t.x + 1
      when h.y = t.y and h.x = t.x - 2 then t.x - 1
      when h.x > t.x  and h.y != t.y then t.x + 1
      when h.x < t.x and h.y != t.y then t.x - 1
      else t.x
    end,
    case
      when abs(h.x - t.x) <= 1 and abs(h.y - t.y) <= 1 then t.y
      when h.x = t.x and h.y = t.y + 2 then t.y + 1
      when h.x = t.x and h.y = t.y - 2 then t.y - 1
      when h.x != t.x and h.y > t.y then t.y + 1
      when h.x != t.x and h.y < t.y then t.y - 1
      else t.y
    end
  from pos t join knots h using (step) where knot = 7
) select *, 8 knot from pos;

insert into knots
with recursive pos (step, x, y) as (
  select 1, 0, 0
  union
  select
    step + 1,
    case
      when abs(h.x - t.x) <= 1 and abs(h.y - t.y) <= 1 then t.x
      when h.y = t.y and h.x = t.x + 2 then t.x + 1
      when h.y = t.y and h.x = t.x - 2 then t.x - 1
      when h.x > t.x  and h.y != t.y then t.x + 1
      when h.x < t.x and h.y != t.y then t.x - 1
      else t.x
    end,
    case
      when abs(h.x - t.x) <= 1 and abs(h.y - t.y) <= 1 then t.y
      when h.x = t.x and h.y = t.y + 2 then t.y + 1
      when h.x = t.x and h.y = t.y - 2 then t.y - 1
      when h.x != t.x and h.y > t.y then t.y + 1
      when h.x != t.x and h.y < t.y then t.y - 1
      else t.y
    end
  from pos t join knots h using (step) where knot = 8
) select *, 9 knot from pos;

insert into knots
with recursive pos (step, x, y) as (
  select 1, 0, 0
  union
  select
    step + 1,
    case
      when abs(h.x - t.x) <= 1 and abs(h.y - t.y) <= 1 then t.x
      when h.y = t.y and h.x = t.x + 2 then t.x + 1
      when h.y = t.y and h.x = t.x - 2 then t.x - 1
      when h.x > t.x  and h.y != t.y then t.x + 1
      when h.x < t.x and h.y != t.y then t.x - 1
      else t.x
    end,
    case
      when abs(h.x - t.x) <= 1 and abs(h.y - t.y) <= 1 then t.y
      when h.x = t.x and h.y = t.y + 2 then t.y + 1
      when h.x = t.x and h.y = t.y - 2 then t.y - 1
      when h.x != t.x and h.y > t.y then t.y + 1
      when h.x != t.x and h.y < t.y then t.y - 1
      else t.y
    end
  from pos t join knots h using (step) where knot = 9
) select *, 10 knot from pos;

\timing on
\unset QUIET

\echo
\echo Day 09

select
  count(1) filter (where knot = 2) "Part 1",
  count(1) filter (where knot = 10) "Part 2"
from (select distinct x, y, knot from knots) uniq;
