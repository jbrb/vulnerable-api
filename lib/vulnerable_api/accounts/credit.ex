defmodule VulnerableApi.Accounts.Credit do
  use Ecto.Schema
  import Ecto.Changeset

  alias VulnerableApi.Accounts.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "credits" do
    field :amount, :integer
    belongs_to :user, User

    timestamps()
  end

  def changeset(credit, attrs) do
    cast(credit, attrs, [:amount, :user_id])
  end
end
