defmodule Hauer.Router do
    use Plug.Router

    plug :match
    plug :dispatch

    filename = "./conf.yml" #todo spostare in conf
    parsed = :yamerl_constr.file(filename)

    # [[{'resources', ['example1', 'example2']}]]
    [[{_, resources}]] = parsed

    Enum.map(resources, fn resource ->
        get "/#{resource}" do
            conn |> send_resp(200, resource)
        end
    end)

    get "/" do
        conn
        |> send_resp(200, inspect(parsed))
    end

    def start_link do
        Plug.Adapters.Cowboy2.http(__MODULE__, [])
    end
end