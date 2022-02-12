defmodule VulnerableApiWeb.GraphQL.Types.AccountTypes do
  use Absinthe.Schema.Notation

  object :user do
    field :id, :string
    field :email, :string
    field :full_name, :string
    field :address, :string
    field :government_id, :string
    field :role, :string
    field :status, :string
    field :credits, :integer
    field :is_private, :boolean
  end
end
