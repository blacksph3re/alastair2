defmodule Alastair.EventEditor do
  use Alastair.Web, :model
  

  schema "event_editors" do
    field :user_id, :string

    belongs_to :event, Alastair.Event
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:event_id, :user_id])
    |> validate_required([:event_id, :user_id])
  end
end
