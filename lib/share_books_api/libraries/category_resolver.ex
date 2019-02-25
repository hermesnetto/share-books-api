defmodule ShareBooksApi.Libraries.CategoryResolver do
  alias ShareBooksApi.Libraries

  def all(_args, _info) do
    {:ok, Libraries.list_categories()}
  end

  def find(%{id: id}, _info) do
    case Libraries.get_category!(id) do
      nil -> {:error, "Category not found!"}
      category -> {:ok, category}
    end
  end

  def create(_parent, args, _info) do
    Libraries.create_category(args)
  end
end
