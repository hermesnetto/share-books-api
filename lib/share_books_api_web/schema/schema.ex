defmodule ShareBooksApiWeb.Schema do
  use Absinthe.Schema
  import_types(ShareBooksApiWeb.Schema.Types)

  query do
    field :users, list_of(:user) do
      resolve(&ShareBooksApi.Accounts.UserResolver.all/2)
    end

    field :user, type: :user do
      arg(:id, non_null(:id))
      resolve(&ShareBooksApi.Accounts.UserResolver.find/2)
    end
  end
end