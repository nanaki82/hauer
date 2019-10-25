defmodule Mix.Tasks.Hauer do
  use Mix.Task

  @moduledoc """
  Hauer's Mix task.
  """

  @impl Mix.Task
  @shortdoc "Scaffold a new route"
  def run(args) do
    Mix.shell().info("Hauer command line 1.0")

    verb = args |> Enum.at(0)
    resource_name = args |> Enum.at(1)

    case verb do
      "resource" ->
        case Hauer.FS.add_resource(resource_name) do
          {:ok, _} -> 
            Hauer.Configuration.add_resource(resource_name)
            Mix.shell().info("Created #{resource_name}")
          {:error, message} -> 
            Mix.shell().error(message)
        end
      _ ->
        Mix.shell().info("I'm afraid I can't do that, Dave.")
    end

    Mix.shell().info("All done.")
  end
end
