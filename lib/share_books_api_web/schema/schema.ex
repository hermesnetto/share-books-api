defmodule ShareBooksApiWeb.Schema do
  use Absinthe.Schema
  alias ShareBooksApi.Accounts.UserResolver
  alias ShareBooksApi.Libraries.{BookResolver, CategoryResolver}

  import_types(ShareBooksApiWeb.Schema.Types)

  query do
    @desc "Get the current user"
    field :me, :user do
      resolve(&UserResolver.find_me/2)
    end

    @desc "Get all users"
    field :users, list_of(:user) do
      resolve(&UserResolver.all/2)
    end

    @desc "Get a single user by its id"
    field :user, type: :user do
      arg(:id, non_null(:id))
      resolve(&UserResolver.find_by_user_id/2)
    end

    @desc "Get all books"
    field :books, type: list_of(:book) do
      resolve(&BookResolver.all/2)
    end

    @desc "Get a single book by its id"
    field :book, type: :book do
      arg(:id, non_null(:id))
      resolve(&BookResolver.find/2)
    end

    @desc "Get all categories"
    field :categories, type: list_of(:category) do
      resolve(&CategoryResolver.all/2)
    end

    @desc "Get a single category by its id"
    field :category, type: :category do
      arg(:id, non_null(:id))
      resolve(&CategoryResolver.find/2)
    end
  end

  mutation do
    field :login, type: :session do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&UserResolver.login/2)
    end

    field :logout, type: :user do
      arg(:id, non_null(:id))
      resolve(&UserResolver.logout/2)
    end

    @desc "Create a user"
    field :create_user, type: :user do
      arg(:name, non_null(:string))
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&UserResolver.create/3)
    end

    @desc "Create a category"
    field :create_category, type: :category do
      arg(:title, non_null(:string))

      resolve(&CategoryResolver.create/3)
    end

    @desc "Create a book"
    field :create_book, type: :book do
      arg(:author, :string)
      arg(:description, :string)
      arg(:image, :string)
      arg(:is_rented, :boolean)
      arg(:publication_date, :string)
      arg(:publisher, :string)
      arg(:title, non_null(:string))
      arg(:category, :id)

      resolve(&BookResolver.create/3)
    end
  end
end
