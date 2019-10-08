defmodule YamerlWrapper do
  @moduledoc false

  def file(path) do
    Application.start(:yamerl)
    :yamerl_constr.file(path)
  end
end
