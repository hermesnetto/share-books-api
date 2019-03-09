defmodule ShareBooksApi.Repo.Migrations.CreateQueues do
  use Ecto.Migration

  def change do
    create table(:queues) do
      add :user_id, references(:users, on_delete: :nothing)
      add :book_id, references(:books, on_delete: :nothing)

      timestamps()
    end

    create index(:queues, [:user_id])
    create index(:queues, [:book_id])
  end
end
