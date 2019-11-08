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
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
