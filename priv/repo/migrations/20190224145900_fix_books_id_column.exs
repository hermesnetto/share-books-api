defmodule ShareBooksApi.Repo.Migrations.FixBooksIdColumn do
  use Ecto.Migration

  def change do
    rename table(:rents), :books_id, to: :book_id
  end
end
