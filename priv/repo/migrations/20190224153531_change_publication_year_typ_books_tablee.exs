defmodule ShareBooksApi.Repo.Migrations.ChangePublicationYearTypBooksTablee do
  use Ecto.Migration

  def change do
    alter table(:books) do
      remove :publication_year
      add :publication_date, :string
    end
  end
end
