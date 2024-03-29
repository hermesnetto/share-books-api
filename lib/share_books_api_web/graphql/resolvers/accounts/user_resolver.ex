defmodule ShareBooksApiWeb.Accounts.UserResolver do
  alias ShareBooksApi.{Accounts, AuthHelper, Guardian}

  def all(_args, _info), do: {:ok, Accounts.list_users()}

  def find_by_book(%{owner_id: user_id}, _args, _info), do: get_user(user_id)

  def find_by_rent(%{user_id: user_id}, _args, _info), do: get_user(user_id)

  def find_by_queue(%{user_id: user_id}, _args, _info), do: get_user(user_id)

  def find_by_user_id(%{id: id}, _info), do: get_user(id)

  def find_me(_args, %{context: %{current_user: current_user}}), do: get_user(current_user.id)

  def find_me(_args, %{context: _context}), do: {:ok, nil}

  def create(_parent, %{input: args}, _info), do: Accounts.create_user(args)

  def authorize(%{input: %{email: email, password: password}}, _info) do
    with {:ok, user} <- AuthHelper.login_with_email_pass(email, password),
         {:ok, jwt, _} <- Guardian.encode_and_sign(user),
         {:ok, _} <- Accounts.store_token(user, jwt) do
      {:ok, %{token: jwt}}
    end
  end

  def signout(_args, %{context: %{current_user: current_user}}) do
    Accounts.revoke_token(current_user)
    {:ok, current_user}
  end

  def signout(_args, _info), do: {:error, "Please log in first!"}

  defp get_user(user_id) do
    case Accounts.get_user(user_id) do
      nil -> {:error, "User not found!"}
      user -> {:ok, user}
    end
  end
end
