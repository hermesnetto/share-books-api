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
alias ShareBooksApi.Libraries.Book
alias ShareBooksApi.Libraries.Category

Repo.insert!(%User{
  name: "John Doe",
  email: "jon.doe@mail.com",
  encrypted_password: "dhjffsdcdscdvf"
})

Repo.insert!(%Category{
  title: "Horror"
})

Repo.insert!(%Book{
  author: "H. P. Lovecraft",
  description:
    "The Call of Cthulhu is a short story by American writer H. P. Lovecraft. Written in the summer of 1926, it was first published in the pulp magazine Weird Tales, in February 1928.",
  image:
    "https://d1w7fb2mkkr3kw.cloudfront.net/assets/images/book/lrg/9781/5005/9781500584337.jpg",
  is_rented: false,
  publisher: "",
  publication_date: "February, 1928",
  title: "The Call of Cthulhu",
  user_id: 1,
  category_id: 1
})
