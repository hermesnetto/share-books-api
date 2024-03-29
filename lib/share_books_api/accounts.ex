defmodule ShareBooksApi.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias ShareBooksApi.Repo

  alias ShareBooksApi.Accounts.User

  @doc """
  Returns the list of users.
  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.
  """
  def get_user(id), do: Repo.get(User, id)

  @doc """
  Creates a user.
  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.
  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.
  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.
  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  @doc """
  Store a user token
  """
  def store_token(%User{} = user, token) do
    user
    |> User.store_token_changeset(%{token: token})
    |> Repo.update()
  end

  @doc """
  Revoke a user token
  """
  def revoke_token(%User{} = user) do
    user
    |> User.store_token_changeset(%{token: nil})
    |> Repo.update()
  end
end
