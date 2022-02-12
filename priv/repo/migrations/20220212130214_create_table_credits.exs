defmodule VulnerableApi.Repo.Migrations.CreateTableCredits do
  use Ecto.Migration

  def change do
    create table(:credits, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :amount, :integer
      add :user_id, references(:users, type: :binary_id)

      timestamps()
    end

    create index(:credits, [:user_id])
  end
end
