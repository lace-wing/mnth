defmodule Mnth.Builtin.Targets.Ghostty do
  @moduledoc """
  Target definition for Ghostty.
  """

  @behaviour Mnth.Target

  alias Mnth.Roles

  import Color, only: [to_hex: 1]

  @impl true
  def render(%Roles{} = r, name, opts \\ []) do
    name =
      if Keyword.get(opts, :ghostty_naming, false) do
        name |> String.replace(~r/[-_ ]+/, " ") |> String.capitalize()
      else
        name
      end

    layer_lines = [
      "background = #{to_hex(r.bg_base)}",
      "foreground = #{to_hex(r.ui_base)}",
      "cursor-color = #{to_hex(r.ui_popped)}",
      "cursor-text = #{to_hex(r.bg_base)}",
      "selection-background = #{to_hex(r.bg_lifted)}",
      "selection-foreground = #{to_hex(r.ui_lifted)}"
    ]

    palette_lines =
      Enum.with_index(r.ansi) |> Enum.map(fn {c, i} -> "palette = #{i}=#{to_hex(c)}" end)

    %{
      name => ((palette_lines ++ layer_lines) |> Enum.join("\n")) <> "\n"
    }
  end

  defp to_hex(c) do
    with {:ok, c} <- Color.new(c) do
      Color.to_hex(%{c | alpha: nil})
    end
  end
end
