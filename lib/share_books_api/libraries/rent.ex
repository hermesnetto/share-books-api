defmodule ShareBooksApi.Libraries.Rent do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rents" do
    field :expiration_date, :date
    belongs_to :user, ShareBooksApi.Accounts.User
    belongs_to :book, ShareBooksApi.Libraries.Book

    timestamps()
  end

  @doc false
  def changeset(rent, attrs) do
    rent
    |> cast(attrs, [:expiration_date])
    |> validate_required([:expiration_date])
  end
end
