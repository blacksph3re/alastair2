defmodule Alastair.UserService do
  use Alastair.Web, :controller # To use render

  # For tests so they can run without the core being up
  def static_user(conn) do
    tmp = Plug.Conn.get_req_header(conn, "x-auth-token")
    if tmp == [] || hd(tmp) == "admin" do
      Plug.Conn.assign(conn, :user, %{id: "asd123", first_name: "Nico", last_name: "Westerbeck", superadmin: true, disabled_superadmin: false})
    else
      Plug.Conn.assign(conn, :user, %{id: "asd123", first_name: "Nico", last_name: "Westerbeck", superadmin: false, disabled_superadmin: false})
    end
  end


  defp convert_to_boolean(anything) do
    case anything do
      n when is_bitstring(n) -> n == "1"
      n when is_number(n) -> n == 1
      n when is_boolean(n) -> n
      _ -> false
    end
  end

  defp parse_superadmin_permissions(response) do
    case response.status_code do
      200 ->
        Enum.any?(Poison.decode!(response.body)["data"], fn(x) -> 
          x["object"] == "alastair" && x["action"] == "administer"
        end)
      _ -> false
    end   
  end

  defp fetch_superadmin_permissions(conn, id) do
    tmp = Plug.Conn.get_req_header(conn, "x-auth-token")
    if tmp != [] do
       token = hd(tmp);
      case HTTPoison.get("http://oms-core-elixir:4000/my_permissions", [{"Content-Type", "application/json"}, {"X-Auth-Token", token}]) do
        {:ok, response} -> parse_superadmin_permissions(response)
        _ -> false
      end
    else
      false
    end
  end

  # Parsing a response is a bit ugly...
  defp parse_oms_user(conn, response) do
    case Poison.decode(response.body) do
      {:ok, body} -> 
      
        user = %{
          id: to_string(body["data"]["id"]),
          first_name: body["data"]["first_name"],
          last_name: body["data"]["last_name"],
          bodies: body["data"]["bodies"],
          is_superadmin: body["data"]["user"]["superadmin"]
        }

        admin = Repo.get_by(Alastair.Admin, user_id: user.id)

        superadmin_permission = fetch_superadmin_permissions(conn, body["data"]["id"])
        IO.inspect(superadmin_permission)

        # TODO superadmin should be fetched more elegantly
        user = user 
        |> Map.put(:superadmin, user.is_superadmin || (admin != nil && admin.active) || superadmin_permission)
        |> Map.put(:disabled_superadmin, admin != nil && !admin.active) 
        |> Map.delete(:is_superadmin)



        Plug.Conn.assign(conn, :user, user)
      _ -> 
        response |> IO.inspect
        conn
        |> Plug.Conn.put_status(:internal_server_error)
        |> render(Alastair.ErrorView, "error.json", message: "Could not parse core response for user data")
    end
  end

  # HTTPoison returns :ok even on non-2xx status code, so we have to check ourselves
  defp check_error(conn, response) do
    IO.inspect(response)
    case response.status_code do
      200 -> parse_oms_user(conn, response)
      401 ->         
        conn
        |> Plug.Conn.put_status(:unauthorized)
        |> render(Alastair.ErrorView, "error.json", message: "Core did not authenticate token")
      _ ->
        conn
        |> Plug.Conn.put_status(:internal_server_error)
        |> render(Alastair.ErrorView, "error.json", message: "Something went wrong inside the core")
    end
  end

  def oms_user(conn) do
    tmp = Plug.Conn.get_req_header(conn, "x-auth-token")
    if tmp != [] do
       token = hd(tmp);
      case HTTPoison.post("http://oms-core-elixir:4000/tokens/user", "{\"token\": \"" <> token <> "\"}", [{"Content-Type", "application/json"}, {"X-Auth-Token", token}]) do
        {:ok, response} -> check_error(conn, response)
        {:error, _error} ->     
          conn
          |> Plug.Conn.put_status(:internal_server_error)
          |> render(Alastair.ErrorView, "error.json", message: "Could not contact core")
      end
    else
      conn
      |> Plug.Conn.put_status(:unauthorized)
      |> render(Alastair.ErrorView, "error.json", message: "No auth token provided")
    end
  end
end
