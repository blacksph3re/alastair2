defmodule Alastair.ShoppingListControllerTest do
  use Alastair.ConnCase


  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end
  def create_event(conn) do
    conn = post conn, event_path(conn, :create), event: %{name: "Develop Yourself 3"}
    %{"data" => %{"id" => id}} = json_response(conn, 201)
    id
  end

  test "generates a shopping list", %{conn: conn} do
    event_id = create_event(conn)
    conn = get conn, event_shopping_list_path(conn, :shopping_list, event_id)
    assert json_response(conn, 200)["data"] |> map_inclusion(%{"mapped" => [], "unmapped" => []})
  end

  test "generates a shopping list on seeded db", %{conn: conn} do
    Alastair.Seeds.ExampleSeed.run()
    event = Alastair.Repo.get_by!(Alastair.Event, name: "Develop Yourself 3")
    conn = get conn, event_shopping_list_path(conn, :shopping_list, event.id)
    assert json_response(conn, 200)["data"]["mapped"] |> is_list
    refute json_response(conn, 200)["data"]["mapped"] |> Enum.empty?
  end
end
