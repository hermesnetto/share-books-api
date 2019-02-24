# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ShareBooksApi.Repo.insert!(%ShareBooksApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias ShareBooksApi.Repo
alias ShareBooksApi.Accounts.User

Repo.insert! %User{
  name: "John Doe",
  email: "jon.doe@mail.com",
  encrypted_password: "dhjffsdcdscdvf"
}
