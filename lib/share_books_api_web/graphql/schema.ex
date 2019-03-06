defmodule ShareBooksApiWeb.Schema do
  use Absinthe.Schema
  alias ShareBooksApiWeb.{Accounts, Libraries}

  import_types(ShareBooksApiWeb.Schema.Types)

  query do
    @desc "Get the current user in the session"
    field :me, :user do
      resolve(&Accounts.UserResolver.find_me/2)
    end

    @desc "Get all users"
    field :users, list_of(:user) do
      resolve(&Accounts.UserResolver.all/2)
    end

    @desc "Get a single user by its id"
    field :user, type: :user do
      arg(:id, non_null(:id))

      resolve(&Accounts.UserResolver.find_by_user_id/2)
    end

    @desc "Get all books"
    field :books, type: list_of(:book) do
      resolve(&Libraries.BookResolver.all/2)
    end

    @desc "Get a single book by its id"
    field :book, type: :book do
      arg(:id, non_null(:id))

      resolve(&Libraries.BookResolver.find_by_book_id/2)
    end

    @desc "Get all categories"
    field :categories, type: list_of(:category) do
      resolve(&Libraries.CategoryResolver.all/2)
    end

    @desc "Get a single category by its id"
    field :category, type: :category do
      arg(:id, non_null(:id))

      resolve(&Libraries.CategoryResolver.find_by_book_id/2)
    end

    @desc "Get all rents of a specific book"
    field :rents, type: list_of(:rent) do
      arg(:book_id, non_null(:id))

      resolve(&Libraries.RentResolver.find_all_by_book_id/2)
    end

    @desc "Get a single rent by its id"
    field :rent, type: :rent do
      arg(:id, non_null(:id))

      resolve(&Libraries.RentResolver.find_by_rent_id/2)
    end
  end

  mutation do
    @desc "Authorize a user"
    field :authorize, type: :session do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&Accounts.UserResolver.authorize/2)
    end

    field :signout, type: :user do
      arg(:id, non_null(:id))

      resolve(&Accounts.UserResolver.signout/2)
    end

    @desc "Create a user"
    field :create_user, type: :user do
      arg(:name, non_null(:string))
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&Accounts.UserResolver.create/3)
    end

    @desc "Create a category"
    field :create_category, type: :category do
      arg(:title, non_null(:string))

      resolve(&Libraries.CategoryResolver.create/3)
    end

    @desc "Create a book"
    field :create_book, type: :book do
      arg(:title, non_null(:string))
      arg(:author, :string)
      arg(:description, :string)
      arg(:image, :string)
      arg(:is_rented, :boolean)
      arg(:publication_date, :string)
      arg(:publisher, :string)
      arg(:category_id, :id)

      resolve(&Libraries.BookResolver.create/3)
    end

    @desc "Update a book"
    field :update_book, type: :book do
      arg(:id, non_null(:id))
      arg(:title, :string)
      arg(:author, :string)
      arg(:description, :string)
      arg(:image, :string)
      arg(:is_rented, :boolean)
      arg(:publication_date, :string)
      arg(:publisher, :string)
      arg(:category_id, :id)

      resolve(&Libraries.BookResolver.update/3)
    end

    @desc "Delete a book"
    field :delete_book, type: :book do
      arg(:id, non_null(:id))

      resolve(&Libraries.BookResolver.delete/3)
    end

    @desc "Rent a Book"
    field :rent_book, type: :rent do
      arg(:book_id, non_null(:id))

      resolve(&Libraries.RentResolver.rent_book_if_available/3)
    end

    @desc "Give back a Book"
    field :return_book, type: :rent do
      arg(:rent_id, non_null(:id))

      resolve(&Libraries.RentResolver.return_book/2)
    end
  end
end