defmodule ShareBooksApi.Actions.Comment do
  use Ecto.Schema
  import Ecto.Changeset
  alias ShareBooksApi.{Accounts, Libraries}

  schema "comments" do
    field :message, :string
    field :title, :string

    belongs_to :user, Accounts.User, foreign_key: :user_id
    belongs_to :book, Libraries.Book, foreign_key: :book_id

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:title, :message, :user_id, :book_id])
    |> validate_required([:title, :message, :user_id, :book_id])
    |> unique_constraint(:user_id)
    |> unique_constraint(:book_id)
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:book_id)
  end
end
