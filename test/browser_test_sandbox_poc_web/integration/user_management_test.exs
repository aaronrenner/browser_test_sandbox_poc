defmodule BrowserTestSandboxPocWeb.UserManagementTest do
  use ExUnit.Case, async: true
  use Wallaby.DSL

  alias Wallaby.Ecto, as: WallabyEcto

  test "managing users", context do
    {:ok, session_1} = WallabyEcto.start_session_with_sandbox(context)

    session_1
    |> Browser.visit("users")
    |> Browser.assert_has(Query.text("Listing Users"))
    |> Browser.click(Query.link("New"))
    |> Browser.fill_in(Query.text_field("Name"), with: "Aaron")
    |> Browser.click(Query.button("Save"))
    |> Browser.click(Query.link("Back"))
    |> Browser.assert_has(Query.text("Listing Users"))
    |> Browser.assert_has(Query.text("Aaron"))

    {:ok, session_2} = WallabyEcto.start_session_with_sandbox(context)

    session_2
    |> Browser.visit("users")
    |> Browser.assert_has(Query.text("Listing Users"))
    |> Browser.assert_has(Query.text("Aaron"))
  end

  test "users don't carry over from one test to another", context do
    {:ok, session} = WallabyEcto.start_session_with_sandbox(context)

    session
    |> Browser.visit("users")
    |> Browser.assert_has(Query.text("Listing Users"))
    |> Browser.refute_has(Query.text("Aaron"))
  end
end
