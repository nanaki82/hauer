defmodule Mix.Tasks.Hauer do
  use Mix.Task

  @moduledoc """
  Hauer's Mix task.
  """

  @impl Mix.Task
  @shortdoc "Scaffold a new route"
  def run(args) do
    IO.puts("Hauer command line 1.0")
    # todo remove, debug purpose only
    args_string = Enum.join(args, ", ")
    Mix.shell().info(args_string)

    verb = args |> Enum.at(0)
    resource_name = args |> Enum.at(1)

    case verb do
      "update" ->
        Mix.shell().info("Updating configuration with #{resource_name}")
        update_config(resource_name)
        :ok

      "resource" ->
        Mix.shell().info("Creating #{resource_name}")
        new_resource(resource_name)
        :ok

      _ ->
        Mix.shell().info("I'm afraid I can't do that, Dave.")
    end

    Mix.shell().info("All done.")
  end

  @doc """
  Create a new resource tree in the lib directory. Module and directory will
  have the same name of the resource.
  """
  def new_resource(resource_name) do
    {:ok, pwd} = File.cwd()
    full_path = "#{pwd}/lib/#{resource_name}"
    module_full_path = "#{full_path}/#{resource_name}.ex"

    # todo remove it
    Mix.shell().info(full_path)
    it_s_new? = !File.exists?(module_full_path)

    case it_s_new? do
      true ->
        File.mkdir!(full_path)
        File.touch!(module_full_path)

      _ ->
        Mix.shell().info("the resource allready exists in #{module_full_path}")
    end
  end

  @doc """
  Update the project configuration according to resource name
  """
  def update_config(resource_name) do
    Hauer.Configuration.add_resource(resource_name)
  end
end
