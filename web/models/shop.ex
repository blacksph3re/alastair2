defmodule Alastair.Shop do
  use Alastair.Web, :model

  schema "shops" do
    field :name, :string
    field :location, :string
    belongs_to :currency, Alastair.Currency

    has_many :shopping_items, Alastair.ShoppingItem

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :location])
    |> validate_required([:name, :location])
  end
end