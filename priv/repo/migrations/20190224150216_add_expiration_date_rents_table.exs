defmodule ShareBooksApi.Repo.Migrations.AddExpirationDateRentsTable do
  use Ecto.Migration

  def change do
    alter table(:rents) do
      add :expiration_date, :date
    end
  end
end
