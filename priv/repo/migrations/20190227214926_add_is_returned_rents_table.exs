defmodule ShareBooksApi.Repo.Migrations.AddIsReturnedRentsTable do
  use Ecto.Migration

  def change do
    alter table(:rents) do
      add :book_returned, :boolean, default: false, null: false
    end
  end
end
