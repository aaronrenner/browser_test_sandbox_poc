use Mix.Config

# Configure your database
config :browser_test_sandbox_poc, BrowserTestSandboxPoc.Repo,
  username: "postgres",
  password: "postgres",
  database: "browser_test_sandbox_poc_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :browser_test_sandbox_poc, BrowserTestSandboxPocWeb.Endpoint,
  http: [port: 4002],
  server: true

config :browser_test_sandbox_poc, :sql_sandbox, true

config :wallaby, :otp_app, :browser_test_sandbox_poc

# Print only warnings and errors during test
config :logger, level: :warn
