defmodule Crisco.Link do
  use Crisco.Web, :model

  before_insert Link, :set_token

  schema "links" do
    has_many :visits, Visit

    field :url, :string
    field :token, :string
    field :ip_address, :string
    field :user_agent, :string

    timestamps
  end

  def find_by_token!(token) do
    from(l in Link, where: l.token == ^token) |> Repo.one
  end

  def token_exists?(token) do
    from(l in Link, where: l.token == ^token, select: 1, limit: 1) |> Repo.one === 1
  end

  def set_token(changeset) do
    Changeset.put_change(changeset, :token, generate_token)
  end

  defp generate_token do
    token = UUID.uuid4(:hex) |> String.slice(0..5)

    case token_exists?(token) do
      true -> generate_token
      false -> token
    end
  end

  @required_fields ~w(url ip_address user_agent)
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
    |> Validation.URL.validate(:url)
  end
end
