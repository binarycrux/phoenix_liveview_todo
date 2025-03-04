import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :taskify, Taskify.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "taskify_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: System.schedulers_online() * 2

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :taskify, TaskifyWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "AX6/FXxwoO4yzoHwCV1qMTkaoZOnkF0xtcYy/BId2X98FOO+nGN1re6az3OiFuuE",
  server: false

# In test we don't send emails
config :taskify, Taskify.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Enable helpful, but potentially expensive runtime checks
config :phoenix_live_view,
  enable_expensive_runtime_checks: true

# Import local test config
if File.exists?("#{__DIR__}/#{Mix.env()}.local.exs") do
  require Logger
  import_config "#{Mix.env()}.local.exs"
else
  require Logger
  Logger.warning("Didn't find '#{Mix.env()}.local.exs'")
end
