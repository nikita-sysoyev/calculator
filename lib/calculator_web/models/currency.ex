defmodule CalculatorWeb.Currency do
  use CalculatorWeb, :model

  alias __MODULE__

  schema "currencies" do
    field :name, :string
    field :code, :string, size: 15
  end

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, [:name, :code])
    |> validate_required([:name, :code])
    |> validate_length(:code, max: 15)
  end
end
