defmodule ShareBooksApiWeb.Schema do
  use Absinthe.Schema
  alias ShareBooksApi.Accounts.UserResolver
  alias ShareBooksApi.Libraries.BookResolver
  alias ShareBooksApi.Libraries.CategoryResolver

  import_types(ShareBooksApiWeb.Schema.Types)

  query do
    @desc "Get all users"
    field :users, list_of(:user) do
      resolve(&UserResolver.all/2)
    end

    @desc "Get a single user by its id"
    field :user, type: :user do
      arg(:id, non_null(:id))
      resolve(&UserResolver.find/2)
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
end