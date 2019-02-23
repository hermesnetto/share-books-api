defmodule ShareBooksApi.Repo do
  use Ecto.Repo,
    otp_app: :share_books_api,
    adapter: Ecto.Adapters.Postgres
end
