defmodule ShareBooksApi.Libraries.CategoryResolver do
  alias ShareBooksApi.Libraries

  def all(_args, _info), do: {:ok, Libraries.list_categories()}

  def find_by_book_id(%{id: id}, _info) do
    case Libraries.get_category!(id) do
      nil -> {:error, "Category not found!"}
      category -> {:ok, category}
    end
  end

  def create(_parent, args, %{context: %{current_user: _current_user}}) do
    Libraries.create_category(args)
  end

  def create(_parent, args, %{context: _context}) do
    {:error, "You need be logged in to create categories!"}
  end
end
