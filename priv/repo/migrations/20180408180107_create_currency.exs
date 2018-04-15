defmodule Calculator.Repo.Migrations.CreateCurrency do
  use Ecto.Migration

  def change do
    create table(:currencies) do
      add :name, :string
      add :code, :string, size: 15
    end
  end
end
