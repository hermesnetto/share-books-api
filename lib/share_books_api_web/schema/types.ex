defmodule ShareBooksApiWeb.Schema.Types do
  use Absinthe.Schema.Notation
  alias ShareBooksApi.Accounts.UserResolver
  alias ShareBooksApi.Libraries.{BookResolver, RentResolver, CategoryResolver}

  @desc "A user of the Library"
  object :user do
    field :id, :id
    field :name, :string
    field :email, :string

    field :books, list_of(:book) do
      resolve(&BookResolver.all_by_user/3)
    end
  end

  @desc "A category of a book, used to group related books"
  object :category do
    field :id, :id
    field :title, :string

    field :books, list_of(:book) do
      resolve(&BookResolver.all_by_category/3)
    end
  end

  @desc "A book"
  object :book do
    field :id, :id
    field :author, :string
    field :description, :string
    field :image, :string
    field :is_rented, :boolean
    field :publication_date, :string
    field :publisher, :string
    field :title, :string

    field :user, :user do
      resolve(&UserResolver.find_by_book/3)
    end

    field :rent, :rent do
      resolve(&RentResolver.find_by_book/3)
    end

    field :rents, list_of(:rent) do
      resolve(&RentResolver.find_all_by_book_id/3)
    end

    field :category, :category do
      resolve(&CategoryResolver.find_by_book/3)
    end
  end

  @doc "A rent of a book"
  object :rent do
    field :id, :id
    field :user_id, :id
    field :book_id, :id
    field :due_date, :string
    field :book_returned, :boolean
    field :status, :string
    field :days_left, :string

    field :user, :user do
      resolve(&UserResolver.find_by_rent/3)
    end
  end

  @doc "The current session"
  object :session do
    field :token, :string
  end
end
