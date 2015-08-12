defmodule Crisco.LinkView do
  use Crisco.Web, :view

  alias Crisco.Link

  def link_to_url(%Link{token: token}) do
    url = full_url(token)

    link(url, to: url)
  end

  defp full_url(token) do
    if port === 80 do
      "http://#{hostname}/#{token}"
    else
      "http://#{hostname}:#{port}/#{token}"
    end
  end

  defp hostname do
    Application.get_env(:crisco, Crisco.Endpoint)[:url][:host]
  end

  defp port do
    Application.get_env(:crisco, Crisco.Endpoint)[:http][:port]
  end
end
