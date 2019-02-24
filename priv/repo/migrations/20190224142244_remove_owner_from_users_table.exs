defmodule ShareBooksApi.Repo.Migrations.RemoveOwnerFromUsersTable do
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove :owner_id
    end
  end
end
