defmodule Crisco.ValidationFormats do

  @ip_address ~r/^(\d{1,3}\.){3}\d{1,3}$/

  def ip_address do
    @ip_address
  end
end
