defmodule ShareBooksApi.Feedbacks do
  @moduledoc """
  The Feedbacks context.
  """

  import Ecto.Query, warn: false
  alias ShareBooksApi.Repo

  alias ShareBooksApi.Feedbacks.Comment

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
end
