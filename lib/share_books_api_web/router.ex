defmodule ShareBooksApiWeb.Router do
  use ShareBooksApiWeb, :router

  pipeline :api do
  end

  scope "/api" do
    pipe_through :api
    
    forward "/graphiql", Absinthe.Plug.GraphiQL, 
      schema: ShareBooksApiWeb.Schema
      
    forward "/", Absinthe.Plug, 
      schema: ShareBooksApiWeb.Schema
  end
end
