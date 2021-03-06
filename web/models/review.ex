defmodule Alastair.Review do
  use Alastair.Web, :model

  schema "reviews" do
    field :rating, :integer
    field :review, :string
    field :user_id, :string
    belongs_to :recipe, Alastair.Recipe

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:rating, :review, :user_id, :recipe_id])
    |> validate_required([:rating, :review, :user_id, :recipe_id])
    |> foreign_key_constraint(:recipe_id)
    |> validate_number(:rating, greater_than_or_equal_to: 0)
    |> validate_number(:rating, less_than_or_equal_to: 5)
  end
end
