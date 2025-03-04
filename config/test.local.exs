import Config

config :taskify, Taskify.Repo,
  username: "postgres",
  password: "Post@localhost127!",
  hostname: "localhost",
  database: "taskify_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: System.schedulers_online() * 2
