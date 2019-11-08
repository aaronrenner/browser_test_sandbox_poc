defmodule Wallaby.Ecto do
  @moduledoc """
  Wallaby's integration with Ecto's sandbox
  """
  @type start_session_with_sandbox_opt ::
          {:repos, module}
          | Wallaby.start_session_opts()

  @spec start_session_with_sandbox(map, [start_session_with_sandbox_opt]) ::
          {:ok, Wallaby.Session.t()} | {:error, Wallaby.reason()}
  def start_session_with_sandbox(context, opts \\ []) when is_list(opts) do
    {sandbox_opts, start_session_opts} = Keyword.split(opts, [:repos])

    repos = Keyword.get_lazy(sandbox_opts, :repos, &get_repos_for_otp_app/0)

    metadata =
      repos
      |> Enum.map(&checkout_ecto_repos(&1, context[:async]))
      |> metadata_for_ecto_repos()

    start_session_opts =
      start_session_opts
      |> Keyword.merge(metadata: metadata)

    Wallaby.start_session(start_session_opts)
  end

  defp checkout_ecto_repos(repo, async) do
    # This is currently getting run once per start_session_with_sandbox/2
    # call. It seems to be ok, though... first time it returns :ok, and
    # subsequent times it returns {:already, :owner}.
    _ = Ecto.Adapters.SQL.Sandbox.checkout(repo)

    unless async, do: Ecto.Adapters.SQL.Sandbox.mode(repo, {:shared, self()})

    repo
  end

  defp metadata_for_ecto_repos([]), do: Map.new()
  defp metadata_for_ecto_repos(repos), do: Phoenix.Ecto.SQL.Sandbox.metadata_for(repos, self())

  defp get_repos_for_otp_app do
    otp_app()
    |> ecto_repos
  end

  defp ecto_repos(nil), do: []
  defp ecto_repos(otp_app), do: Application.get_env(otp_app, :ecto_repos, [])

  defp otp_app do
    Application.fetch_env!(:wallaby, :otp_app)
  end
end
