defmodule Snapshot.Router do
  use Plug.Router
  import Plug.Conn
  require Logger

  alias Snapshot.Scraper

  plug Plug.Logger
  plug :match
  plug :dispatch

  get "/" do
    conn = fetch_query_params(conn)

    url = conn.query_params["url"]

    html = Scraper.scrape(url)

    conn
    |> send_resp(200, html)
    |> halt
  end

  get "/favicon.ico" do
    conn
    |> send_resp(200, "ok")
    |> halt
  end

end
