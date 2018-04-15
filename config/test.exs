use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :calculator, CalculatorWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :calculator, Calculator.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "hello_db_user",
  password: "password",
  database: "hello_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
