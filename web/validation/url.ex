defmodule Crisco.Validation.URL do
  use Crisco.Web, :validator

  def validate(changeset, field) do
    validate_change(changeset, field, fn(_, url) ->
      case url |> to_char_list |> :http_uri.parse do
        {:ok, _} -> []
        {:error, _} -> [{field, "invalid url"}]
      end
    end)
  end
end
