defmodule ShareBooksApi.Libraries.RentResolver do
  alias ShareBooksApi.Libraries

  # 15 days = 1296000 seconds
  @seconds_to_return_book 600

  @doc """
  Gets all rents
  """
  def find_all_by_book_id(%{book_id: book_id}, _info) do
    {:ok, Libraries.list_rents_by_book(book_id) |> add_status_to_every_rent}
  end

  @doc """
  Gets a Rent by its ID
  """
  def find_by_rent_id(%{id: id}, _info) do
    case Libraries.get_rent(id) do
      nil -> {:error, "Rent not found!"}
      rent -> {:ok, add_status_to_rent(rent)}
    end
  end

  @doc """
  Gets a Rent by the Book and User ID's
  """
  def find_by_book(%{id: book_id}, _args, _context) do
    case Libraries.get_rented_book(book_id) do
      nil -> {:error, nil}
      rent -> {:ok, add_status_to_rent(rent)}
    end
  end
  
  @doc """
  Rent a Book if it's available or throw an error if it's alredy rented
  """
  def rent_book_if_available(_parent, args, %{context: %{current_user: user}}) do
    case Libraries.get_rented_book(args.book_id) do
      nil -> rent_book(args, user)
      rent -> {:error, "This Book is already rented!"}
    end
  end
  
  @doc """
  Creates a new Rent
  """
  def rent_book(args, %{id: user_id}) do
    due_date = DateTime.utc_now() |> DateTime.add(@seconds_to_return_book, :second)

    attrs =
      Map.merge(args, %{
        user_id: user_id,
        due_date: due_date
      })
      
    Libraries.create_rent(attrs)
  end
  
  @doc """
  Not authorized to create Rents
  """
  def rent_book(_parent, _args, %{context: _ctx}), do: {:error, "You need be logged in to rent a book!"}
  
  @doc """
  Marks a Rent as returned
  """
  def return_book(_parent, %{id: id}, %{context: %{current_user: _user}}) do
    case Libraries.get_rent(id) do
      nil -> {:error, "Rent not found!"}
      rent -> Libraries.update_rent(rent, %{book_returned: true})
    end
  end
  
  # Adds an attribute :status in every Rents
  defp add_status_to_every_rent(rents), do: for rent <- rents, do: add_status_to_rent rent

  # Adds an attribute :status to a specific Rent
  defp add_status_to_rent(rent), do: Map.put(rent, :status, get_status rent)

  # Returns the :status of a Rent
  defp get_status(%{book_returned: true}), do: "Returned"
  
  # Returns the :status of a Rent
  defp get_status(%{book_returned: false, due_date: due_date}) do
    case DateTime.compare(due_date, DateTime.utc_now()) do
      :gt -> "Rented"
      :lt -> "Expired"
      :eq -> "Expired"
    end
  end
end