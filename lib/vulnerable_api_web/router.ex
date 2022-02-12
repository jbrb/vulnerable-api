defmodule VulnerableApiWeb.Router do
  use VulnerableApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :graphql do
    # plug Guardian here
  end

  scope "/api" do
    pipe_through :api

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
