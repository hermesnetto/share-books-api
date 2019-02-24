defmodule ShareBooksApi.Libraries.Book do
  use Ecto.Schema
  import Ecto.Changeset

  schema "books" do
    field :author, :string
    field :description, :string
    field :image, :string
    field :is_rented, :boolean, default: false
    field :publication_year, :date
    field :publisher, :string
    field :title, :string
    belongs_to :user, ShareBooksApi.Accounts.User
    belongs_to :category, ShareBooksApi.Libraries.Category

    timestamps()
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:title, :description, :author, :publisher, :publication_year, :image, :is_rented])
    |> validate_required([:title, :is_rented])
  end
end
