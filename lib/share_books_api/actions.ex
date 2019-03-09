defmodule ShareBooksApi.Actions do
  @moduledoc """
  The Actions context.
  """

  import Ecto.Query, warn: false
  alias ShareBooksApi.Repo

  alias ShareBooksApi.Actions.Comment

  @doc """
  Returns the list of comments.
  """
  def list_comments do
    Repo.all(Comment)
  end

  def list_comments_by_book(book_id) do
    Repo.all(from comment in Comment, where: comment.book_id == ^book_id)
  end

  @doc """
  Gets a single comment.
  """
  def get_comment(id), do: Repo.get(Comment, id)

  @doc """
  Creates a comment.
  """
  def create_comment(attrs \\ %{}) do
    %Comment{}
    |> Comment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a comment.
  """
  def update_comment(%Comment{} = comment, attrs) do
    comment
    |> Comment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Comment.
  """
  def delete_comment(%Comment{} = comment) do
    Repo.delete(comment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking comment changes.
  """
  def change_comment(%Comment{} = comment) do
    Comment.changeset(comment, %{})
  end

  alias ShareBooksApi.Actions.Queue

  @doc """
  Returns the list of queues.
  """
  def list_queues do
    Repo.all(Queue)
  end

  def list_queues_by_book(book_id) do
    Repo.all(from queue in Queue, where: queue.book_id == ^book_id)
  end

  @doc """
  Gets a single queue.
  """
  def get_queue(id), do: Repo.get(Queue, id)

  @doc """
  Creates a queue.
  """
  def create_queue(attrs \\ %{}) do
    %Queue{}
    |> Queue.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a queue.
  """
  def update_queue(%Queue{} = queue, attrs) do
    queue
    |> Queue.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Queue.
  """
  def delete_queue(%Queue{} = queue) do
    Repo.delete(queue)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking queue changes.
  """
  def change_queue(%Queue{} = queue) do
    Queue.changeset(queue, %{})
  end

  alias ShareBooksApi.Libraries.Rent

  @doc """
  Returns the list of rents.
  """
  def list_rents do
    Repo.all(Rent)
  end

  def list_rents_by_book(book_id) do
    Repo.all(from rent in Rent, where: rent.book_id == ^book_id)
  end

  @doc """
  Gets a single rent.
  """
  def get_rent(id), do: Repo.get(Rent, id)

  @doc """
  """
  def get_rented_book(book_id) do
    Repo.get_by(Rent, book_id: book_id, book_returned: false)
  end

  @doc """
  Creates a rent.

  ## Examples
  """
  def create_rent(attrs \\ %{}) do
    %Rent{}
    |> Rent.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a rent.

  ## Examples
  """
  def update_rent(%Rent{} = rent, attrs) do
    rent
    |> Rent.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Rent.

  ## Examples
  """
  def delete_rent(%Rent{} = rent) do
    Repo.delete(rent)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking rent changes.
  """
  def change_rent(%Rent{} = rent) do
    Rent.changeset(rent, %{})
  end
end
