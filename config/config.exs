use Mix.Config

config :hauer,
    resources_dir: "middleware"

import_config "#{Mix.env()}.exs"
