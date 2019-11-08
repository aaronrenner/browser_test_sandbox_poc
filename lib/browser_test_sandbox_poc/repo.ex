defmodule BrowserTestSandboxPoc.Repo do
  use Ecto.Repo,
    otp_app: :browser_test_sandbox_poc,
    adapter: Ecto.Adapters.Postgres
end
