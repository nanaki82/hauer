defmodule Hauer.FS do
  @moduledoc false

  @resources_dir Application.get_env(:hauer, :resources_dir)

  defp create_resources_dir() do
    resources_dir = get_resources_dir()

    if !File.exists?(resources_dir) do
      File.mkdir!(resources_dir)
    end

    :ok
  end

  defp get_resources_dir() do
    {:ok, pwd} = File.cwd()
    "#{pwd}/lib/#{@resources_dir}"
  end

  def get_resource_dir(resource_name) do
    "#{get_resources_dir()}/#{resource_name}.ex"
  end

  def add_resource(resource_name) do
    create_resources_dir()

    resource_file_path = get_resource_dir(resource_name)
    already_exists = File.exists?(resource_file_path)
 
    case already_exists do
      true ->
        {:error, "Resource file already exists: #{resource_file_path}"}
      _ ->
        File.touch!(resource_file_path)
        {:ok, resource_file_path}
    end
  end

  def remove_resource(resource_name) do
    resource_file_path = get_resource_dir(resource_name)

    File.rm!(resource_file_path)
    
    :ok
  end
end
