defmodule Alastair.EventController do
  use Alastair.Web, :controller
  alias Alastair.Event
  alias Alastair.EventEditor

  def get_event(id) do
    Repo.get!(Event, id) |> Repo.preload([:event_editors])
  end

  def create(conn, %{"event" => event_params}) do
    case Repo.transaction(fn -> 
      changeset = Event.changeset(%Event{}, event_params)
      event = case Repo.insert(changeset) do
        {:ok, event} -> event
        {:error, changeset} -> Repo.rollback(changeset)
      end

      Repo.insert!(%EventEditor{event_id: event.id, user_id: conn.assigns.user.id})
      event
    end) do
      {:ok, event} -> 
        conn
        |> put_status(:created)
        |> render("show.json", event: event)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Alastair.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def index(conn, _params) do
    events = from(p in Event,
      join: q in EventEditor,
      where: p.id == q.event_id and q.user_id == ^conn.assigns.user.id)
    |> Repo.all

    render(conn, "index.json", events: events)
  end

  def show(conn, %{"id" => id}) do
    event = get_event(id)
    |> Repo.preload([shop: [:currency], event_editors: [], meals: []])

    render(conn, "show.json", event: event)
  end


  def update(conn, %{"id" => id, "event" => event_params}) do
    event = get_event(id)
    changeset = Event.changeset(event, event_params)

    case Repo.update(changeset) do
      {:ok, event} ->
        from(p in Alastair.ShoppingListNote,
          where: p.event_id == ^id)
        |> Repo.delete_all

        event = Repo.preload(event, [{:shop, [:currency]}, meals: [], event_editors: []])
        
        render(conn, "show.json", event: event)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Alastair.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
