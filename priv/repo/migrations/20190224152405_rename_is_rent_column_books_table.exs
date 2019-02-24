defmodule ShareBooksApi.Repo.Migrations.RenameIsRentColumnBooksTable do
  use Ecto.Migration

  def change do
    rename table(:books), :is_rent, to: :is_rented
  end
end
