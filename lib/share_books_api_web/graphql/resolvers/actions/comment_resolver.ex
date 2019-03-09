defmodule ShareBooksApiWeb.Actions.CommentResolver do
  alias ShareBooksApi.{Actions}

  def list_comments_by_book(%{book_id: book_id}, _info),
    do: {:ok, Actions.list_comments_by_book(book_id)}

  def create_comment(%{input: comment}, %{context: %{current_user: user}}) do
    Map.put(comment, :user_id, user.id) |> Actions.create_comment()
  end

  def create_comment(_args, %{context: _context}),
    do: {:error, "You need be logged in to leave comment!"}

  def update_comment(%{input: args}, %{context: %{current_user: _user}}) do
    case Actions.get_comment(args.id) do
      nil ->
        {:error, "Comment not found!"}

      comment ->
        case Actions.update_comment(comment, args) do
          {:ok, comment} -> {:ok, comment}
          {:error, _err} -> {:error, "Could not update the comment #{comment.title}"}
        end
    end
  end

  def update_comment(_args, %{context: _context}),
    do: {:error, "You need be logged in to update a comment!"}
end
