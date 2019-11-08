ExUnit.start()
{:ok, _} = Application.ensure_all_started(:wallaby)

Application.put_env(:wallaby, :base_url, BrowserTestSandboxPocWeb.Endpoint.url())

Ecto.Adapters.SQL.Sandbox.mode(BrowserTestSandboxPoc.Repo, :manual)
