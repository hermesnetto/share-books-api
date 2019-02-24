defmodule ShareBooksApi.Repo.Migrations.CreateRents do
  use Ecto.Migration

  def change do
    create table(:rents) do
      add :user_id, references(:users, on_delete: :nothing)
      add :books_id, references(:books, on_delete: :nothing)

      timestamps()
    end

    create index(:rents, [:user_id])
    create index(:rents, [:books_id])
  end
end
