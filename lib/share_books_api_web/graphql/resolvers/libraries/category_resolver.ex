defmodule ShareBooksApiWeb.Libraries.CategoryResolver do
  alias ShareBooksApi.Libraries

  def all(_args, _info), do: {:ok, Libraries.list_categories()}

  def find_by_book(%{category_id: nil}, _args, _info), do: {:error, nil}

  def find_by_book(%{category_id: id}, _args, _info), do: find_category(id, nil)

  def find_by_book_id(%{id: id}, _info), do: find_category(id, "Category not found!")

  def create(%{input: args}, %{context: %{current_user: _current_user}}),
    do: Libraries.create_category(args)

  def create(_args, %{context: _context}),
    do: {:error, "You need be logged in to create categories!"}

  defp find_category(id, error) do
    case Libraries.get_category(id) do
      nil -> {:error, error}
      category -> {:ok, category}
    end
  end
end
