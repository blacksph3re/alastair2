defmodule Alastair.RecipeView do
  use Alastair.Web, :view

  def render("index.json", %{recipes: recipes}) do
    %{data: render_many(recipes, Alastair.RecipeView, "recipe.json")}
  end

  def render("show.json", %{recipe: recipe}) do
    %{data: render_one(recipe, Alastair.RecipeView, "recipe.json")}
  end

  def render("recipe.json", %{recipe: recipe}) do
    %{id: recipe.id,
      name: recipe.name,
      description: recipe.description,
      person_count: recipe.person_count,
      instructions: recipe.instructions,
      database_id: Map.get(recipe, :database_id, nil),
      ingredients: 
        case Ecto.assoc_loaded?(recipe.recipes_ingredients) do
          true -> render_many(recipe.recipes_ingredients, Alastair.RecipeView, "recipe_ingredient.json");
          false -> nil;
        end
    }
  end

  def render("recipe_ingredient.json", %{recipe: recipe_ingredient}) do
    %{quantity: recipe_ingredient.quantity,
      ingredient: render_one(recipe_ingredient.ingredient, Alastair.IngredientView, "ingredient.json"),
      ingredient_id: recipe_ingredient.ingredient_id
    }
  end
end
