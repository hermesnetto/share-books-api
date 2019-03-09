defmodule ShareBooksApi.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :title, :string
      add :message, :string
      add :user_id, references(:users, on_delete: :nothing)
      add :book_id, references(:books, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:comments, [:user_id])
    create unique_index(:comments, [:book_id])
  end
end
