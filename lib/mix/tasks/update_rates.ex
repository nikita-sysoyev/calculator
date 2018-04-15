defmodule Mix.Tasks.Calculator.UpdateRates do
  use Mix.Task

  alias CalculatorWeb.{Currency, Rate}
  alias Calculator.Repo

  @shortdoc "Updates rates for currencies"

  @moduledoc """
    This is where we would put any long form documentation or doctests.
  """

  def run(_args) do #TODO update only btc, eth, bth by default
    Mix.Task.run "app.start"
    Mix.shell.info "Lets get rates updated!"

    currencies = Repo.all(Currency)

    Enum.each(currencies, fn(x) -> update_rate(x) end)

    Mix.shell.info "Updated."
  end

  def update_rate(currency) do
    IO.puts currency.code

    url = "https://min-api.cryptocompare.com/data/price?fsym=#{currency.code}&tsyms=USD"

    response = HTTPoison.get!(url)
    req = Poison.decode!(response.body)

    if rate = req["USD"] do
      IO.puts currency.code

      Repo.insert(%Rate{value: rate + 0.0, currency: currency})
    end
  end
end