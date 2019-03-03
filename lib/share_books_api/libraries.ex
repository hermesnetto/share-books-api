defmodule ShareBooksApi.Libraries do
  @moduledoc """
  The Libraries context.
  """

  import Ecto.Query, warn: false
  alias ShareBooksApi.Repo

  alias ShareBooksApi.Libraries.Category
  alias ShareBooksApi.Accounts.User

  @doc """
  Returns the list of categories.
  """
  def list_categories do
    Repo.all(Category)
  end

  @doc """
  Gets a single category.
  """
  def get_category(id), do: Repo.get(Category, id)

  @doc """
  Creates a category.
  """
  def create_category(attrs \\ %{}) do
    %Category{}
    |> Category.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a category.
  """
  def update_category(%Category{} = category, attrs) do
    category
    |> Category.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Category.
  """
  def delete_category(%Category{} = category) do
    Repo.delete(category)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking category changes.
  """
  def change_category(%Category{} = category) do
    Category.changeset(category, %{})
  end

  alias ShareBooksApi.Libraries.Book

  @doc """
  Returns the list of books.
  """
  def list_books do
    Repo.all(Book)
  end

  @doc """
  Returns the list of books from a given user.
  """
  def list_books_by_user(user) do
    Repo.all(from p in Book, where: p.user_id == ^user.id)
  end

  @doc """
  Returns the list of books from a given category.
  """
  def list_books_by_category(category) do
    Repo.all(from p in Book, where: p.category_id == ^category.id)
  end

  @doc """
  Gets a single book.
  """
  def get_book(id), do: Repo.get(Book, id)

  @doc """
  Creates a book.
  """
  def create_book(attrs \\ %{}) do
    %Book{}
    |> Book.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a book.
  """
  def update_book(%Book{} = book, attrs) do
    book
    |> Book.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Book.
  """
  def delete_book(%Book{} = book) do
    Repo.delete(book)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking book changes.
  """
  def change_book(%Book{} = book) do
    Book.changeset(book, %{})
  end

  alias ShareBooksApi.Libraries.Rent

  @doc """
  Returns the list of rents.
  """
  def list_rents do
    Repo.all(Rent)
  end

  @doc """
  Gets a single rent.
  """
  def get_rent(id), do: Repo.get(Rent, id)

  @doc """
  Gets a single rent by User and Book ID's
  """
  def get_rent(book_id, user_id) do
    Repo.get_by(Rent, book_id: book_id, user_id: user_id, book_returned: false)
  end

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
