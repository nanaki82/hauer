defmodule Hauer.Configuration do
  @moduledoc """
  Configuration wrapper. It takes current environment and parses config file.
  """
  
  def read do
    Hauer.FS.read_conf()
    |> Jason.decode!(%{:keys => :atoms})
  end

  def write(new_conf) do
    encoded_conf = Jason.encode!(new_conf, %{:pretty => true})

    Hauer.FS.write_conf(encoded_conf)
  end

  def parse_conf(nil) do
    []
  end

  def parse_conf(resources) do
    resources
    |> Enum.map(fn x -> Map.to_list(x) |> List.first() end)
    |> Enum.map(fn {resource, _} -> resource end)
  end

  def add_resource(resource_name) do
    Hauer.Configuration.read()
    |> Map.update(:resources, [], &Enum.concat(&1, [%{resource_name => %{}}]))
    |> Hauer.Configuration.write()
  end
end
