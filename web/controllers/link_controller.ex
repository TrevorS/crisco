defmodule Crisco.LinkController do
  use Crisco.Web, :controller

  plug :scrub_params, "link" when action in [:create]

  def new(conn, _params) do
    render(conn, "new.html", changeset: Link.changeset(%Link{}))
  end

  def create(conn, %{"link" => link_params}) do
    link_params = merge_user_info(conn, link_params)

    changeset = Link.changeset(%Link{}, link_params)

    if changeset.valid? do
      link = Repo.insert!(changeset)

      render(conn, "create.html", link: link)
    else
      render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"token" => [token | _]}) do
    case Link.find_by_token!(token) do
      nil -> redirect(conn, to: link_path(conn, :new))
      link -> redirect(conn, external: link.url)
    end
  end

  defp merge_user_info(conn, params) do
    params |> Map.merge(user_info(conn))
  end

  defp user_info(conn) do
    conn.assigns[:user_info]
  end
end
