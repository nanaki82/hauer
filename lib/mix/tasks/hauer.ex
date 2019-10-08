defmodule Mix.Tasks.Hauer do
  use Mix.Task
    
  @impl Mix.Task
  def run args do
    IO.puts "Hauer command line 1.0"
    Mix.shell().info(Enum.join(args, ", ")) #todo remove, debug purpose only

    verb = args |> Enum.at(0)
    if verb == "resource" do
      resource_name = args |> Enum.at(1)
      Mix.shell().info("Creating #{resource_name}")
      new_resource resource_name
    end

    Mix.shell().info("All done.")
  end

  @doc """
  Create a new resource tree in the lib directory. Module and directory will
  have the same name of the resource.
  """
  def new_resource resource_name do
    {:ok, pwd} = File.cwd()
    full_path = "#{pwd}/lib/#{resource_name}"
    module_full_path = "#{full_path}/#{resource_name}.ex"

    Mix.shell().info(full_path) #todo remove it
    it_s_new? = !File.exists? module_full_path

    case it_s_new? do
      true ->
        File.mkdir! full_path
        File.touch! module_full_path
      _ -> 
        Mix.shell().info("the resource allready exists in #{module_full_path}")
    end
  end
end
