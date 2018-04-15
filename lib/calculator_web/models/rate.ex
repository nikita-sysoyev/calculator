defmodule CalculatorWeb.Rate do
  use CalculatorWeb, :model

  alias __MODULE__

  schema "rates" do
    field :value, :float
    belongs_to :currency, CalculatorWeb.Currency

    timestamps()
  end

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, [:value, :currency_id])
    |> validate_required([:value, :currency_id])
  end

  def get_by_timestamp(currency_id, datetime) do
    from r in Rate,
    where: r.currency_id == ^currency_id,
    where: r.inserted_at <= ^datetime,
    order_by: [desc: r.inserted_at],
    limit: 1
  end

  def get_latest_rate(currency_code) do
    currency = Calculator.Repo.get_by(CalculatorWeb.Currency, code: currency_code)
    time     = DateTime.utc_now |> DateTime.to_naive
    Rate.get_by_timestamp(currency.id, time) |> Calculator.Repo.one!
  end
end
