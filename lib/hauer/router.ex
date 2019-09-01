defmodule Hauer.Router do
    use Plug.Router

    plug :match
    plug :dispatch

    @conf_file Application.get_env(:hauer, :conf_file)

    parsed = YamerlWrapper.file(@conf_file)

    # [[{'resources', ['example1', 'example2']}]]
    [[{_, resources}]] = parsed

    # TODO make it work! :D
    Enum.map(resources, fn resource ->
        get "/#{resource}" do
            conn |> send_resp(200, resource)
        end
    end)

    def start_link do
        Plug.Adapters.Cowboy2.http(__MODULE__, [])
    end
end
