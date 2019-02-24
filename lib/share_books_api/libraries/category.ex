defmodule ShareBooksApi.Libraries.Category do
  use Ecto.Schema
  import Ecto.Changeset

  schema "categories" do
    field :title, :string
    has_many :books, ShareBooksApi.Libraries.Book

    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:title])
    |> validate_required([:title])
    |> unique_constraint([:title])
  end
end
