defmodule ShareBooksApi.Libraries.Rent do
  use Ecto.Schema
  import Ecto.Changeset
  alias ShareBooksApi.{Accounts, Libraries}

  schema "rents" do
    field :due_date, :utc_datetime

    belongs_to :user, Accounts.User, foreign_key: :user_id
    belongs_to :book, Libraries.Book, foreign_key: :book_id

    timestamps()
  end

  @doc false
  def changeset(rent, attrs) do
    rent
    |> cast(attrs, [:due_date, :user_id, :book_id])
    |> validate_required([:due_date, :user_id, :book_id])
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:book_id)
  end
end
