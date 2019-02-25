defmodule ShareBooksApi.Repo.Migrations.AddOwnerBooksTable do
  use Ecto.Migration

  def change do
    alter table(:books) do
      add :owner_id, references(:users, on_delete: :nothing)
    end
  end
end
