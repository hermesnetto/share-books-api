defmodule ShareBooksApi.Accounts.UserResolver do
  alias ShareBooksApi.{Accounts, Libraries, AuthHelper, Guardian}

  def all(_args, _info) do
    {:ok, Accounts.list_users()}
  end

  def find(%Libraries.Book{} = book, _args, _info) do
    case Accounts.get_user!(book.user_id) do
      nil -> {:error, "User not found!"}
      user -> {:ok, user}
    end
  end
  
  def find(%{id: id}, _info) do
    case Accounts.get_user!(id) do
      nil -> {:error, "User not found!"}
      user -> {:ok, user}
    end
  end

  def find(_args, %{context: %{current_user: current_user}}) do
    case Accounts.get_user!(current_user.id) do
      nil -> {:error, "User not found!"}
      user -> {:ok, user}
    end
  end

  def find(_args, %{context: %{current_user: nil}}) do
    {:ok, %{}}
  end

  def login(%{email: email, password: password}, _info) do
    with {:ok, user} <- AuthHelper.login_with_email_pass(email, password),
         {:ok, jwt, _} <- Guardian.encode_and_sign(user),
         {:ok, _ } <- Accounts.store_token(user, jwt) do
      {:ok, %{token: jwt}}
    end
  end

  def logout(_args,  %{context: %{current_user: current_user}}) do
    Accounts.revoke_token(current_user, nil)
    {:ok, current_user}
  end

  def logout(_args, _info) do
    {:error, "Please log in first!"}
end
end