defmodule Crisco.Visit do
  use Crisco.Web, :model

  schema "visits" do
    belongs_to :link, Link

    field :ip_address, :string
    field :user_agent, :string

    timestamps
  end

  @required_fields ~w(ip_address user_agent link_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> Validation.IpAddress.validate(:ip_address)
  end

  def changeset_from_link(link, params \\ :empty) do
    build(link, :visits) |> changeset(params)
  end
end
