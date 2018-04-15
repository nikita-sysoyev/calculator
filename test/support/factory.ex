defmodule Calculator.Factory do
  # with Ecto
  use ExMachina.Ecto, repo: Calculator.Repo
  alias CalculatorWeb.{Currency, Rate}
  alias Calculator.Repo

  def currency_factory do
    %Currency{
      name: "Bitcoin",
      code: "BTC"
    }
  end

  def rate_factory do
    %Rate{
      value: 1.1
    }
  end

end