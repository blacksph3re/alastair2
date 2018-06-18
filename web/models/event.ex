defmodule Alastair.Event do
  use Alastair.Web, :model

  schema "events" do
    field :name, :string
    belongs_to :shop, Alastair.Shop, on_replace: :nilify

    has_many :meals, Alastair.Meal
    has_many :event_editors, Alastair.EventEditor
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:shop_id, :name])
    |> foreign_key_constraint(:shop_id)
  end
end
