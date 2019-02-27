defmodule ShareBooksApi.Repo.Migrations.RemoveConstraintRentsTable do
  use Ecto.Migration

  def change do
    execute "ALTER TABLE rents DROP CONSTRAINT rents_books_id_fkey"
  end
end
