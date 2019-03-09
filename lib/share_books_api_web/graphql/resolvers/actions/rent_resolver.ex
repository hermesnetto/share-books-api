defmodule ShareBooksApiWeb.Actions.RentResolver do
  alias ShareBooksApi.Actions

  @seconds_in_a_day 86400
  @days_allowed_with_book 15
  @seconds_to_return_book @seconds_in_a_day * @days_allowed_with_book

  def find_all_by_book_id(%{id: book_id}, _args, _info), do: find_all_by_book(book_id)
  
  def find_all_by_book_id(%{book_id: book_id}, _info), do: find_all_by_book(book_id)

  def find_by_rent_id(%{id: id}, _info) do
    case Actions.get_rent(id) do
      nil -> {:error, "Rent not found!"}
      rent -> {:ok, rent |> add_status_to_rent |> add_days_left_to_rent}
    end
  end

  def find_by_book(%{id: book_id}, _args, _context) do
    case Actions.get_rented_book(book_id) do
      nil -> {:error, nil}
      rent -> {:ok, rent |> add_status_to_rent |> add_days_left_to_rent}
    end
  end

  def rent_book_if_available(args, %{context: %{current_user: user}}) do
    case Actions.get_rented_book(args.book_id) do
      nil -> rent_book(args, user)
      _rent -> {:error, "This Book is already rented!"}
    end
  end

  def rent_book(args, %{id: user_id}) do
    due_date = DateTime.utc_now() |> DateTime.add(@seconds_to_return_book, :second)

    attrs =
      Map.merge(args, %{
        user_id: user_id,
        due_date: due_date
      })

      Actions.create_rent(attrs)
  end

  def rent_book(_args, %{context: _ctx}),
    do: {:error, "You need be logged in to rent a book!"}

  def return_book(%{rent_id: id}, %{context: %{current_user: _user}}) do
    case Actions.get_rent(id) do
      nil -> {:error, "Rent not found!"}
      rent -> Actions.update_rent(rent, %{book_returned: true})
    end
  end

  # Returns all Rents of a specific Book
  defp find_all_by_book(book_id) do
    {:ok,
      Actions.list_rents_by_book(book_id)
      |> add_status_to_every_rent
      |> add_days_left_to_every_rent}
  end

  # Adds an attribute :status in every Rents
  defp add_status_to_every_rent(rents), do: for(rent <- rents, do: add_status_to_rent(rent))

  # Adds an attribute :status to a specific Rent
  defp add_status_to_rent(rent), do: Map.put(rent, :status, get_status(rent))

  # Adds an attribute :days_left to a specific Rent
  defp add_days_left_to_every_rent(rents), do: for(rent <- rents, do: add_days_left_to_rent(rent))

  # Adds an attribute :days_left to a specific Rent
  defp add_days_left_to_rent(rent), do: Map.put(rent, :days_left, get_days_left(rent))

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

  # Returns the :days_left of a Rent
  defp get_days_left(%{book_returned: true}), do: nil

  # Returns the :days_left of a Rent
  defp get_days_left(%{book_returned: false, status: "Expired"}), do: nil

  # Returns the :days_left of a Rent
  defp get_days_left(%{book_returned: false, status: "Rented", due_date: due_date}) do
    diff_days = DateTime.diff(due_date, DateTime.utc_now()) / @seconds_in_a_day
    Kernel.round(diff_days)
  end
end
