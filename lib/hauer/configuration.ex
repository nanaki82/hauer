defmodule Hauer.Configuration do
  @conf_file Application.get_env(:hauer, :conf_file)

  def read do
    YamerlWrapper.file(@conf_file)
  end
end
