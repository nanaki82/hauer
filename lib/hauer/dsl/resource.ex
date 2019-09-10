defmodule Hauer.Dsl.Resource do
  require Hauer.Dsl.Wrappers

  alias Hauer.Dsl.Wrappers, as: Wrappers

  defmacro map_resources([]) do
    quote do
      raise "You must define at list a route"
    end
  end

  defmacro map_resources(route_list) do
    quote do
      for route <- unquote(route_list) do
        IO.puts("Plugging route #{route}")
        Wrappers.generate_route(route)
      end
    end
  end
end
