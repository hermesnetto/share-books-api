defmodule ShareBooksApiWeb.Libraries.BookResolver do
  alias ShareBooksApi.{Libraries, Accounts}

  def all(_args, _info), do: {:ok, Libraries.list_books()}

  def all_by_user(%Accounts.User{} = user, _args, _info) do
    {:ok, Libraries.list_books_by_user(user)}
  end

  def all_by_category(%Libraries.Category{} = category, _args, _info) do
    {:ok, Libraries.list_books_by_category(category)}
  end

  def find_by_book_id(%{id: id}, _info) do
    case Libraries.get_book(id) do
      nil -> {:error, "Book not found!"}
      book -> {:ok, book}
    end
  end

  def create(_parent, %{input: args}, %{context: %{current_user: current_user}}) do
    args = Map.put(args, :owner_id, current_user.id)
    Libraries.create_book(args)
  end

  def create(_parent, _args, %{context: _context}),
    do: {:error, "You need be logged in to create books!"}

  def delete(_parent, %{id: id}, %{context: %{current_user: _current_user}}) do
    case Libraries.delete_book(id) do
      {:ok, book} -> {:ok, book}
      {:error, _changeset} -> {:error, "Could not delete the book!"}
    end
  end

  def delete(_parent, _args, %{context: _context}),
    do: {:error, "You need be logged in to delete books!"}

  def update(%{input: args}, %{context: %{current_user: _current_user}}) do
    case Libraries.get_book(args.id) do
      nil ->
        {:error, "Book not found!"}

      book ->
        case Libraries.update_book(book, args) do
          {:ok, book} -> {:ok, book}
          {:error, _err} -> {:error, "Could not update the book!"}
        end
    end
  end

  def update(_args, %{context: _context}),
    do: {:error, "You need be logged in to update books!"}
end
