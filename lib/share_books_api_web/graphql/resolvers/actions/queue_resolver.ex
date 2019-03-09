defmodule ShareBooksApiWeb.Actions.QueueResolver do
  alias ShareBooksApi.Actions

  def all_users(%{book_id: book_id}, _info),
    do: {:ok, Actions.list_queues_by_book(book_id)}

  def add_user(%{input: args}, %{context: %{current_user: user}}),
    do: Map.put(args, :user_id, user.id) |> Actions.create_queue()

  def add_user(_args, %{context: _context}),
    do: {:error, "You need be logged in to put your name on the queue!"}

  def remove_user(%{input: args}, %{context: %{current_user: _current_user}}) do
    case Actions.get_queue(args.id) do
      nil ->
        {:error, "You are not on the queue!"}

      queue ->
        case Actions.delete_queue(queue) do
          {:error, _changeset} -> {:error, "Could not remove your name from the queue!"}
          {:ok, queue} -> {:ok, queue}
        end
    end
  end

  def remove_user(_args, %{context: _context}),
    do: {:error, "You need be logged in to remove your name from the queue!"}
end
