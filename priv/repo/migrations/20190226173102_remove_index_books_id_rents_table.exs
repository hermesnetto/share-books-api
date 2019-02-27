defmodule ShareBooksApi.Repo.Migrations.RemoveIndexBooksIdRentsTable do
  use Ecto.Migration

  def change do
    drop index(:rents, [:books_id])
  end
end
