defmodule Crisco.Repo.Migrations.CreateLink do
  use Ecto.Migration

  def change do
    create table(:links) do
      add :url, :string
      add :token, :string
      add :ip_address, :string
      add :user_agent, :string

      timestamps
    end

  end
end
