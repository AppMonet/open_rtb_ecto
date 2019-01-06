defmodule OpenRtbEcto.OpenRtbCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      defp test_data(type, filename, format \\ :map)

      defp test_data(type, filename, :json) do
        Path.join([File.cwd!(), "test", "data", "v2", type, filename])
        |> File.read!()
      end

      defp test_data(type, filename, :map) do
        test_data(type, filename, :json)
        |> Jason.decode!()
      end
    end
  end
end
