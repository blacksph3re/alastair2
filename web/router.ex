defmodule Alastair.Router do
  use Alastair.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Alastair do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", Alastair do
    pipe_through :api

    resources "/events", EventController, except: [:new, :edit] do
      resources "/meals", MealController, except: [:new, :edit]
    end
    resources "/recipes", RecipeController, except: [:new, :edit] do
      resources "/reviews", ReviewController, except: [:new, :edit]
    end
    resources "/ingredients", IngredientController, except: [:new, :edit, :update]
    resources "/measurements", MeasurementController, except: [:new, :edit]
  end
end
