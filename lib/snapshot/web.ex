defmodule Snapshot.Web do

  def init(options) do
    options
  end

  def start_link do
    {:ok, _} = Plug.Adapters.Cowboy.http Snapshot.Router, []
  end

end
