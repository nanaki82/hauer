defmodule Hauer.Router do
  use Plug.Router

 require Hauer.Dsl.Resource
 require Hauer.Dsl.Wrappers
 alias Hauer.Dsl.Resource, as: Dsl

 plug :match
 plug :dispatch

  @conf_file Application.get_env(:hauer, :conf_file)

  parsed = YamerlWrapper.file(@conf_file)

  # [[{'resources', ['example1', 'example2']}]]
  [[{_, resources}]] = parsed

  get "/" do
    conn |> send_resp(200, ":ok")
  end
  
  Dsl.map_resources(resources)

  match _ do
    send_resp(conn, 404, "Yikes! 404")
  end

  def start_link do
      Plug.Adapters.Cowboy2.http(__MODULE__, [])
  end
end
