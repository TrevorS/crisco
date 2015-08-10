defmodule Crisco.LinkTest do
  use Crisco.ModelCase

  alias Crisco.Forge
  alias Crisco.Link

  test "changeset with valid attributes" do
    changeset = Link.changeset(%Link{}, Forge.link_params)
    assert changeset.valid?
  end

  test "changeset with an invalid url" do
    changeset = Link.changeset(%Link{}, Forge.link_params(url: "invalid_url//test.com!"))
    refute changeset.valid?
  end

  test "changeset with an invalid ip address" do
    changeset = Link.changeset(%Link{}, Forge.link_params(ip_address: "127.0.0.0.1"))
    refute changeset.valid?
  end

  test "changeset with no ip address" do
    changeset = Link.changeset(%Link{}, Forge.link_params(ip_address: nil))
    refute changeset.valid?
  end

  test "changeset with no url" do
    changeset = Link.changeset(%Link{}, Forge.link_params(url: nil))
    refute changeset.valid?
  end

  test "changeset with no user agent" do
    changeset = Link.changeset(%Link{}, Forge.link_params(user_agent: nil))
    refute changeset.valid?
  end

  test "changeset with no attributes" do
    changeset = Link.changeset(%Link{}, %{})
    refute changeset.valid?
  end
end
