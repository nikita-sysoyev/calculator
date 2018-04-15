defmodule CalculatorWeb.CalculatorController do
  use CalculatorWeb, :controller

  alias Calculator.Repo
  alias CalculatorWeb.{Rate, Currency}

  def index(conn, params) do
    currency = Repo.get_by(Currency, %{code: params["currency"]})

    unless currency do
      json conn, %{ errors: "wrong currency code" }
    end

    t = params["time"] || (Ecto.Time.utc |> Ecto.Time.to_string)
    d = Ecto.Date.utc |> Ecto.Date.to_string

    {_, time} = NaiveDateTime.from_iso8601("#{d} #{t}")
    rate = Rate.get_by_timestamp(currency.id, time)
     |> Repo.one!

    unless rate do
      json conn, %{ errors: "rate data unavailable" }
    end

    {value, _} = Float.parse(params["value"])

    json conn, %{
      success: true,
      value: value * rate.value
    }
  end
end
