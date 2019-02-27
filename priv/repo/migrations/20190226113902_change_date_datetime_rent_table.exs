defmodule ShareBooksApi.Repo.Migrations.ChangeDateDatetimeRentTable do
  use Ecto.Migration

  def change do
    alter table(:rents) do
      remove :expiration_date
      add :due_date, :utc_datetime
    end
  end
end
