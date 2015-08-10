defmodule Crisco.Plugs.UserInfo do
  import Plug.Conn

  def init(default), do: default

  def call(conn, _default) do
    conn |> assign(:user_info, user_info(conn))
  end

  defp user_info(conn) do
    %{ip_address: ip_address(conn), user_agent: user_agent(conn)}
  end

  defp ip_address(conn) do
    case get_req_header(conn, "x-forwarded-for") do
      header when length(header) > 0 ->
        header |> List.last |> String.split(",") |> List.last |> String.strip
      _ ->
        conn.remote_ip |> Tuple.to_list |> Enum.join(".")
    end
  end

  defp user_agent(conn) do
    header = get_req_header(conn, "user-agent")

    if length(header) == 1, do: hd(header), else: nil
  end
end
