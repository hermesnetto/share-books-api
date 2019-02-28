defmodule ShareBooksApiWeb.Router do
  use ShareBooksApiWeb, :router

  scope "/api" do
    forward "/graphiql", Absinthe.Plug.GraphiQL, schema: ShareBooksApiWeb.Schema
    forward "/", Absinthe.Plug, schema: ShareBooksApiWeb.Schema
  end
end
