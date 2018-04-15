defmodule Mix.Tasks.Calculator.GetCurrencies do
  use Mix.Task

  alias CalculatorWeb.Currency
  alias Calculator.Repo

  @shortdoc "Get currencies"

  def run(_args) do
    Mix.Task.run "app.start"
    Mix.shell.info "Save all currencies"

    url = "https://www.cryptocompare.com/api/data/coinlist/"

    response = HTTPoison.get!(url)
    req = Poison.decode!(response.body)

    Enum.each(Map.values(req["Data"]), fn(x) -> parse_currency_data(x) end)

    Mix.shell.info "Saved."
  end

  def parse_currency_data(hash) do
    IO.puts hash["CoinName"]

    currency = Repo.get_by(Currency, code: hash["Symbol"]) || %Currency{code: hash["Symbol"]}
    changeset = Currency.changeset(currency, %{name: hash["CoinName"]})
    Repo.insert_or_update(changeset)
  end
end