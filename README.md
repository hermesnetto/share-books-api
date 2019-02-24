# ShareBooksApi

## MVP - About

- Allows to register one or more users
  - The user should fill out your name, email and password
- Allows to register one or more books
  - The book should has a (title, description, author, publisher, category, quantity, image)
- Allows a user to rent a book
  - A user can only rent 3 books per time
  - A book can only be rented by one user per time
  - If all units of a book were rented the book should left the available books list
- Allows a user to return a book
  -The book should back to the available books list
- The user can update / delete a book that is not rented at the moment

## To run the project

To start your Phoenix server:

- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
- Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

- Official website: http://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Mailing list: http://groups.google.com/group/phoenix-talk
- Source: https://github.com/phoenixframework/phoenix
