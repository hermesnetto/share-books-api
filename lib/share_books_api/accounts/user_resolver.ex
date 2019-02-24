defmodule ShareBooksApi.Accounts.UserResolver do
  alias ShareBooksApi.Accounts

  def all(_args, _info) do
    {:ok, Accounts.list_users()}
  end

  def find(%{id: id}, _info) do
    case Accounts.get_user!(id) do
      nil -> {:error, "User not found!"}
      user -> {:ok, user}
    end
  end
end