defmodule Snapshot.Scraper do
  use Hound.Helpers
  require Logger

  def absolute_links(html, url) do
    uri = URI.parse(url)
    base_url = "#{uri.scheme}://#{uri.host}"
    html = Regex.replace(~r/src="([^\/].*)"/, html, "src=\"#{base_url}/\\g{1}\"")
    html = Regex.replace(~r/href="([^\/].*)"/, html, "href=\"#{base_url}/\\g{1}\"")
    Regex.replace(~r/base href="(.*)"/, html, "base href=\"#{base_url}/\\g{1}\"")
  end

  def perform(url) do
    IO.puts "starting"
    Hound.start_session
    navigate_to url
    :timer.sleep(3000)
    page_source()
    |> absolute_links(url)
  end

  def scrape(url) do
    Application.ensure_all_started(:hound)
    spawn(fn() -> System.cmd("chromedriver", []) end)
    start_time = timestamp
    html = perform(url)
    end_time = timestamp
    IO.puts "Time: #{(end_time - start_time)/1000} ms"
    html
  end

  def timestamp do
    {mega, sec, micro} = :os.timestamp
    mega * :math.pow(1000,4) + sec * :math.pow(1000,2) + micro
  end
end
