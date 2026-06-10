defmodule Mnth.Builtin.Targets.KmsCon do
  @moduledoc """
  Target definition for kmscon.
  """

  @behaviour Mnth.Target

  alias Mnth.Roles

  @impl true
  def render!(%Roles{} = r, name, _opts \\ []) do
    xr = Mnth.Palette.Xterm.to_xterm(r.ansi)

    layer_lines = [
      "background=#{to_rgb(r.bg_base)}",
      "foreground=#{to_rgb(r.ui_base)}"
    ]

    palette_lines =
      xr
      |> Map.from_struct()
      |> Enum.map(fn {k, v} ->
        k =
          case k do
            :white -> "light-grey"
            :br_black -> "dark-grey"
            :br_white -> "white"
            _ -> String.replace_prefix(Atom.to_string(k), "br_", "light-")
          end

        "#{k}=#{to_rgb(v)}"
      end)

    %{
      name =>
        "palette=custom\n" <>
          ((palette_lines ++ layer_lines)
           |> Enum.map(fn l -> "palette-" <> l end)
           |> Enum.join("\n")) <> "\n"
    }
  end

  # To r,g,b in 0-255
  defp to_rgb(c) do
    {:ok, c} = Color.new(c)

    [c.r, c.g, c.b]
    |> Enum.map(&trunc(&1 * 255))
    |> Enum.join(",")
  end
end
