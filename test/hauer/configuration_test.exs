defmodule ConfigurationTest do
  use ExUnit.Case

  alias Hauer.Configuration

  setup do 
    configuration_backup = Configuration.read()

    on_exit fn -> 
      Configuration.write(configuration_backup)
    end
  end

  test "reading configuration" do
    configuration = Configuration.read()
    assert configuration !== nil
  end

  test "writing configuration" do
    map_test = %{ :test => "is ok!" }
    Configuration.write(map_test)
    test_configuration = Configuration.read()

    assert test_configuration == map_test
  end
end
