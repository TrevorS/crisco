defmodule Crisco.Validation.IpAddress do
  use Crisco.Web, :validator

  @valid_ip_address ~r/^(\d{1,3}\.){3}\d{1,3}$/

  def validate(changeset, field) do
    validate_format(changeset, field, @valid_ip_address)
  end
end
