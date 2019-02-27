defmodule ShareBooksApi.Libraries.RentResolver do
  alias ShareBooksApi.Libraries

  def all(_args, _info), do: {:ok, Libraries.list_rents()}

  def find_by_rent_id(%Libraries.Rent{} = %{id: id}, _info) do
    case Libraries.get_rent!(id) do
      nil -> {:error, "Rent not found!"}
      rent -> {:ok, rent}
    end
  end

  def create(_parent, args, %{context: %{current_user: current_user}}) do
    args = Map.put(args, :user_id, current_user.id)
    Libraries.create_rent(args)
  end

  def create(_parent, args, %{context: _context}) do
    {:error, "You need be logged in to rent a book!"}
  end
end
