defmodule VulnerableApi.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :email, :string
      add :full_name, :string
      add :address, :text
      add :government_id, :text
      add :password_reset_token, :string
      add :password_hash, :string
      add :role, :string
      add :status, :string
      add :is_private, :boolean, default: false
      add :username, :string

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
