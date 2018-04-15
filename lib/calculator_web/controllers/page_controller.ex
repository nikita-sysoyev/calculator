defmodule CalculatorWeb.PageController do
  use CalculatorWeb, :controller

  def index(conn, _params) do
    rates = (Enum.map(["BTC", "ETH", "BTH"], fn(x) -> [x, CalculatorWeb.Rate.get_latest_rate(x)] end)
    	|> Enum.map(fn [a, b] -> {a, b} end)
    	|> Map.new)

    render conn, "index.html", rates: rates
  end
end
