defmodule ShareBooksApi.Repo.Migrations.AddIndexBookIdRentsTable do
  use Ecto.Migration

  def change do
    create index(:rents, [:book_id])
  end
end
