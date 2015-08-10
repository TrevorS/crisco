defmodule Crisco.LinkTest do
  use Crisco.ModelCase

  alias Crisco.Forge
  alias Crisco.Link

  test "changeset with valid attributes" do
    changeset = Link.changeset(%Link{}, Forge.link_params)
    assert changeset.valid?
  end

  test "changeset with an invalid ip address" do
    changeset = Link.changeset(%Link{}, Forge.link_params(ip_address: "127.0.0.0.1"))
    refute changeset.valid?
  end

  test "changeset with no attributes" do
    changeset = Link.changeset(%Link{}, %{})
    refute changeset.valid?
  end
end
