defmodule Alastair.RecipeView do
  use Alastair.Web, :view
  import Alastair.Helper

  def render("index.json", %{recipes: recipes}) do
    %{data: render_many(recipes, Alastair.RecipeView, "recipe.json")}
  end

  def render("show.json", %{recipe: recipe, permissions: permissions}) do
    %{data: render_one(recipe, Alastair.RecipeView, "recipe.json"), 
      meta: render_one(permissions, Alastair.RecipeView, "permissions.json")
    }
  end

  def render("show.json", %{recipe: recipe}) do
    %{data: render_one(recipe, Alastair.RecipeView, "recipe.json")}
  end

  def render("permissions.json", %{recipe: permissions}) do
    %{permissions: %{
      edit_recipe: permissions.edit_recipe,
      delete_recipe: permissions.delete_recipe
    }}
  end

  def render("recipe.json", %{recipe: recipe}) do
    %{id: recipe.id,
      name: recipe.name,
      description: recipe.description,
      person_count: recipe.person_count,
      instructions: recipe.instructions,
      avg_review: recipe.avg_review,
      published: recipe.published,
      created_by: recipe.created_by,
      version: recipe.version,
      root_version: render_assoc_one(recipe.root_version, Alastair.RecipeView, "recipe.json"),
      recipes_ingredients: render_assoc_many(recipe.recipes_ingredients, Alastair.RecipeView, "recipe_ingredient.json"),
      reviews: render_assoc_many(recipe.reviews, Alastair.ReviewView, "review.json")
    }
  end

  def render("recipe_ingredient.json", %{recipe: recipe_ingredient}) do
    %{quantity: recipe_ingredient.quantity,
      comment: recipe_ingredient.comment,
      item_quantity: Map.get(recipe_ingredient, :item_quantity, nil),
      ingredient: render_assoc_one(recipe_ingredient.ingredient, Alastair.IngredientView, "ingredient.json"),
      ingredient_id: recipe_ingredient.ingredient_id
    }
  end
end
