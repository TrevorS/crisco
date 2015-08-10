defmodule Crisco.Repo.Migrations.CreateVisit do
  use Ecto.Migration

  def change do
    create table(:visits) do
      add :ip_address, :string
      add :user_agent, :string
      add :link_id, :integer

      timestamps
    end

  end
end
