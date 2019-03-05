defmodule ShareBooksApiWeb.Router do
  use ShareBooksApiWeb, :router

  pipeline :graphql do
    plug CORSPlug, origin: "http://localhost:3000"
  end
  
  scope "/api" do
    pipe_through :graphql
    forward "/graphiql", Absinthe.Plug.GraphiQL, schema: ShareBooksApiWeb.Schema
    forward "/", Absinthe.Plug, schema: ShareBooksApiWeb.Schema
  end
end
