defmodule Mnth.Builtin.Palettes.HanekawaWhite do
  @moduledoc """
  The Hanekawa White palette.

  # Source
  Picked from:
  - CR neko white hero,
  - character design booklets.

  Adjusted.
  """

  @behaviour Mnth.Palette

  @impl true
  def get!(),
    do: %Mnth.Palette{
      black: color("#040203"),
      dark: color("#151514"),
      somber: color("#2e202a"),
      dim: color("#575460"),
      soft: color("#e3e2e3"),
      light: color("#e8f5ff"),
      white: color("#fffdfe"),
      ansi:
        [
          "#232329",
          "#bf6a73",
          "#768b65",
          "#dabb5a",
          "#6396cc",
          "#8681ad",
          "#deaabb",
          "#e3e2e3",
          "#3b3844",
          "#bb4045",
          "#9dc1a1",
          "#f7ef9f",
          "#b8d6e6",
          "#b48dbb",
          "#e5cae0",
          "#f5f3f5"
        ]
        |> Enum.map(&color/1)
    }

  defp color(a) do
    with({:ok, c} <- Color.new(a)) do
      c
    end
  end
end
