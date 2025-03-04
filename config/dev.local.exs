import Config

# Configure your database
config :taskify, Taskify.Repo,
  username: "postgres",
  password: "Post@localhost127!",
  hostname: "localhost",
  database: "taskify",
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10
