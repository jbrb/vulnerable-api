defmodule VulnerableApiWeb.Router do
  use VulnerableApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :graphql do
    if Mix.env() != :dev, do: plug(VulnerableApiWeb.Plugs.Introspection)
    plug VulnerableApiWeb.Plugs.Context
  end

  scope "/", VulnerableApiWeb do
    pipe_through :api

    get "/free-btc", Controllers.XssController, :xss
  end

  scope "/api" do
    pipe_through :api

    pipe_through :graphql
    post "/send", VulnerableApiWeb.CreditsController, :send_credits

    if Mix.env() == :dev do
      forward "/graphiql", Absinthe.Plug.GraphiQL, schema: VulnerableApiWeb.GraphQL.Schema
    end

    forward "/graphql", Absinthe.Plug, schema: VulnerableApiWeb.GraphQL.Schema
  end

  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
