defmodule Mnth.Builtin.Palettes.HanekawaBlack do
  @moduledoc """
  The Hanekawa Black palette.

  # Source
  Picked from:
  - CR neko white hero,
  - character design booklets.

  Adjusted.
  """

  @behaviour Mnth.Palette

  import Mnth.Builtin.Palettes.HanekawaWhite, only: :functions

  @impl true
  def get!(),
    do: %Mnth.Palette{
      shades()
      | ansi:
          [
            # TODO change colors
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
end
