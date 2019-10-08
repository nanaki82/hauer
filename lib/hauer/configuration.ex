defmodule Hauer.Configuration do
  @conf_file Application.get_env(:hauer, :conf_file)

  def read do 
    File.open! @conf_file, [:read, :utf8], fn file -> 
      conf = IO.read file, :all
      Jason.decode!(conf, %{:keys => :atoms})
    end
  end

  def write new_conf do
    encoded_conf = Jason.encode!(new_conf, %{:pretty => true})
    {:ok, pwd} = File.cwd()

    conf_file_path = "#{pwd}/#{@conf_file}"

    # todo remove it
    conf_file_exists? = File.exists?(conf_file_path)

    if conf_file_exists? == false do
      File.touch!(conf_file_path)
    end

    {:ok, io_device} = File.open conf_file_path, [:write, :utf8]
    IO.write io_device, encoded_conf
    File.close io_device
  end


  def parse_conf nil do
    []
  end

  def parse_conf resources do
    resources
      |> Enum.map(fn x -> Map.to_list(x) |> List.first end) 
      |> Enum.map(fn ({resource, _}) -> resource end)
  end
end
