defmodule Hauer.Dsl.Wrappers do
  defmacro generate_route(route) do
    quote do
      slug = unquote(route)

      get "/#{slug}" do
        send_resp(var!(conn), 200, "hello!")
      end
    end
  end
end
