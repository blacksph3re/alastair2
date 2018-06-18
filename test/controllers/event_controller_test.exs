defmodule Alastair.EventControllerTest do
  use Alastair.ConnCase

  alias Alastair.Event
  @event_attrs %{name: "Develop Yourself 3"}
  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "shows event", %{conn: conn} do
    conn = post conn, event_path(conn, :create), event: @event_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, event_path(conn, :show, id)
    assert json_response(conn, 200)["data"] |> map_inclusion(%{"id" => id})
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    %{:euro => euro} = Alastair.Seeds.CurrencySeed.run
    shop = Repo.insert! %Alastair.Shop{
      name: "Aldi",
      location: "Dresden",
      currency: euro
    }
    conn = post conn, event_path(conn, :create), event: @event_attrs
    assert id = json_response(conn, 201)["data"]["id"]

    conn = put conn, event_path(conn, :update, id), event: %{shop_id: shop.id}
    assert json_response(conn, 200)["data"]["id"] == id
    assert Repo.get_by(Event, %{id: id})
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, event_path(conn, :create), event: @event_attrs
    assert id = json_response(conn, 201)["data"]["id"]

    conn = put conn, event_path(conn, :update, id), event: %{shop_id: -1}
    assert json_response(conn, 422)["errors"] != %{}
  end
end
