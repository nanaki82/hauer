defmodule Hauer.Router do
    use Plug.Router

    plug :match
    plug :dispatch

    @conf_file Application.get_env(:hauer, :conf_file)

    parsed = YamerlWrapper.file(@conf_file)

    #TODO what follow can't work because define_ruote cannot be executed outside a function. 
    #TODO actual if we want to see this works we have to switch to macros because you cannot
    #TODO invoke "get/1" macro inside another macro-like as start_link. 

    # [[{'resources', ['example1', 'example2']}]]
    [[{_, resources}]] = parsed

    def define_route r do
        get "/#{r}" do
            conn |> send_resp(200, r)
        end
    end

    resources |>
        Enum.map(&define_route/1)

    def start_link do
        Plug.Adapters.Cowboy2.http(__MODULE__, [])
    end
end
