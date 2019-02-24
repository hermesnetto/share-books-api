defmodule ShareBooksApi.Repo.Migrations.CreateBooks do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :title, :string
      add :description, :string
      add :author, :string
      add :publisher, :string
      add :publication_year, :date
      add :image, :string
      add :is_rent, :boolean, default: false, null: false
      add :category_id, references(:categories, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:books, [:category_id])
    create index(:books, [:user_id])
  end
end
