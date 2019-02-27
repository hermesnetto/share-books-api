defmodule ShareBooksApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias ShareBooksApi.{Accounts, Libraries}

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :encrypted_password, :string
    field :name, :string
    field :token, :string

    has_many :books, Libraries.Book, foreign_key: :owner_id
    has_many :rents, Libraries.Rent, foreign_key: :user_id

    timestamps()
  end

  @doc false
  def changeset(%Accounts.User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password])
    |> validate_required([:name, :email, :password])
    |> validate_length(:password, min: 6, max: 20)
    |> unique_constraint(:email, downcase: true)
    |> put_password_hash()
  end

  def store_token_changeset(%Accounts.User{} = user, attrs) do
    user
    |> cast(attrs, [:token])
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :encrypted_password, Comeonin.Bcrypt.hashpwsalt(pass))

      _ ->
        changeset
    end
  end
end
