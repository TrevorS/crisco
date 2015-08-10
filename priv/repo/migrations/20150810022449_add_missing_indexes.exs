defmodule Crisco.Repo.Migrations.AddMissingIndexes do
  use Ecto.Migration

  def change do
    create index(:links, [:token], unique: true)
    create index(:visits, [:link_id])
  end
end
