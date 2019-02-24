defmodule ShareBooksApi.Repo.Migrations.UpdateUsersTable do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :owner_id, references(:users, on_delete: :nothing)
    end
  end
end
