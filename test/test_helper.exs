ExUnit.start

Mix.Task.run "ecto.create", ["--quiet"]
Mix.Task.run "ecto.migrate", ["--quiet"]
Ecto.Adapters.SQL.begin_test_transaction(Crisco.Repo)

defmodule Blacksmith.Config do
  def save(repo, map) do
    map |> repo.insert!
  end

  def save_all(repo, list) do
    list |> Enum.map(&repo.insert!/1)
  end
end

defmodule Crisco.Forge do
  use Blacksmith

  alias Crisco.Link
  alias Crisco.Visit

  @save_one_function &Blacksmith.Config.save/2
  @save_all_function &Blacksmith.Config.save_all/2

  register :link,
    __struct__: Link,
    url: "http://example.com/fake-url",
    token: "abc12",
    ip_address: "127.0.0.1",
    user_agent: "Test/UA"

  register :random_link,
    [prototype: :user],
    url: Faker.Internet.url,
    token: Faker.Lorem.characters(5),
    ip_address: Faker.Internet.ip_v4_address

  register :link_params,
    url: "http://example.com/fake-url",
    token: "abc12",
    ip_address: "127.0.0.1",
    user_agent: "Test/UA"

  register :visit,
    __struct__: Visit,
    ip_address: "127.0.0.1",
    user_agent: "Test/UA",
    link_id: saved_link(Repo).id

  register :random_visit,
    __struct__: Visit,
    ip_address: "127.0.0.1",
    user_agent: "Test/UA",
    link_id: saved_random_link(Repo).id

  register :visit_params,
    ip_address: "127.0.0.1",
    user_agent: "Test/UA",
    link_id: 42
end
