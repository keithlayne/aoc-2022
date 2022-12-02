# AoC 2022

Run everything:

```sh
docker compose up
cat */solution.sql | docker compose exec -T db psql
# OR (with your local psql)
cat */solution.sql | psql postgres://postgres@127.0.0.1:15432
# OR (works with zsh)
psql postgres://postgres@127.0.0.1:15432 < */solution.sql
```