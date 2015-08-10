defmodule Crisco.VisitTest do
  use Crisco.ModelCase

  alias Crisco.Forge
  alias Crisco.Visit

  test "changeset with valid attributes" do
    changeset = Visit.changeset(%Visit{}, Forge.visit_params)
    assert changeset.valid?
  end

  test "changeset with an invalid ip address" do
    changeset = Visit.changeset(%Visit{}, Forge.visit_params(ip_address: "1234.0.0.1"))
    refute changeset.valid?
  end

  test "changeset with no ip address" do
    changeset = Visit.changeset(%Visit{}, Forge.link_params(ip_address: nil))
    refute changeset.valid?
  end

  test "changeset with no user agent" do
    changeset = Visit.changeset(%Visit{}, Forge.link_params(user_agent: nil))
    refute changeset.valid?
  end

  test "changeset with no attributes" do
    changeset = Visit.changeset(%Visit{}, %{})
    refute changeset.valid?
  end
end
