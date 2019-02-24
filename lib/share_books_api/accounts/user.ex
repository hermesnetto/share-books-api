defmodule ShareBooksApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias ShareBooksApi.Accounts.User

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :encrypted_password, :string
    field :name, :string
    field :token, :string
    has_many :books, ShareBooksApi.Libraries.Book, foreign_key: :user_id

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password])
    |> validate_required([:name, :email, :password])
    |> validate_length(:password, min: 6, max: 20)
    |> unique_constraint(:email, downcase: true)
    |> put_password_hash()
  end

  def store_token_changeset(%User{} = user, attrs) do
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
