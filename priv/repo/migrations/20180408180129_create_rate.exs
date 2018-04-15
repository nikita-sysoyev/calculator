defmodule Calculator.Repo.Migrations.CreateRate do
  use Ecto.Migration

  def change do
    create table(:rates) do
		  add :value, :float, null: false
		  add :currency_id, references(:currencies, on_delete: :delete_all), null: false

		  timestamps()
    end

    create index(:rates, [:currency_id])
  end
end
