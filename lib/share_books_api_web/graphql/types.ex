defmodule ShareBooksApiWeb.Schema.Types do
  use Absinthe.Schema.Notation
  alias ShareBooksApiWeb.{Accounts, Libraries, Actions}

  @desc "A user of the Library"
  object :user do
    field :id, :id
    field :name, :string
    field :email, :string
    field :books, list_of(:book), do: resolve(&Libraries.BookResolver.all_by_user/3)
  end

  @desc "A category of a book, used to group related books"
  object :category do
    field :id, :id
    field :title, :string
    field :books, list_of(:book), do: resolve(&Libraries.BookResolver.all_by_category/3)
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
    field :user, :user, do: resolve(&Accounts.UserResolver.find_by_book/3)
    field :rent, :rent, do: resolve(&Actions.RentResolver.find_by_book/3)
    field :rents, list_of(:rent), do: resolve(&Actions.RentResolver.find_all_by_book_id/3)
    field :category, :category, do: resolve(&Libraries.CategoryResolver.find_by_book/3)
  end

  @desc "A rent of a book"
  object :rent do
    field :id, :id
    field :user_id, :id
    field :book_id, :id
    field :due_date, :string
    field :book_returned, :boolean
    field :status, :string
    field :days_left, :string

    field :user, :user do
      resolve(&Accounts.UserResolver.find_by_rent/3)
    end
  end

  @desc "The current session"
  object :session do
    field :token, :string
  end

  @desc "User comments of a Book"
  object :comment do
    field :id, :id
    field :title, :string
    field :message, :string
  end

  @desc "User queue to rent a Book"
  object :queue do
    field :id, :id
    field :user, :user, do: resolve(&Accounts.UserResolver.find_by_queue/3)
  end

  input_object :create_user_input do
    field :name, non_null(:string)
    field :email, non_null(:string)
    field :password, non_null(:string)
  end

  input_object :create_category_input do
    field :title, non_null(:string)
  end

  input_object :create_book_input do
    field :title, non_null(:string)
    field :author, :string
    field :description, :string
    field :image, :string
    field :is_rented, :boolean
    field :publication_date, :string
    field :publisher, :string
    field :category_id, :id
  end

  input_object :update_book_input do
    field :id, non_null(:id)
    field :title, :string
    field :author, :string
    field :description, :string
    field :image, :string
    field :is_rented, :boolean
    field :publication_date, :string
    field :publisher, :string
    field :category_id, :id
  end

  input_object :create_comment_input do
    field :book_id, non_null(:id)
    field :title, non_null(:string)
    field :message, non_null(:string)
  end

  input_object :update_comment_input do
    field :id, non_null(:id)
    field :title, :string
    field :message, :string
  end

  input_object :add_user_on_queue_input do
    field :book_id, non_null(:id)
  end

  input_object :remove_user_from_queue_input do
    field :id, non_null(:id)
  end
end
