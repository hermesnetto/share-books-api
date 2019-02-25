defmodule ShareBooksApi.Repo.Migrations.ChangeUserIdToOwnerIdBooksTable do
  use Ecto.Migration

  def change do
    alter table(:books) do
      remove :user_id
    end
  end
end
