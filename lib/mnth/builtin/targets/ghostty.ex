defmodule Mnth.Builtin.Targets.Ghostty do
  @moduledoc """
  Target definition for Ghostty.
  """

  @behaviour Mnth.Target

  alias Mnth.Roles

  @impl true
  def render!(%Roles{} = r, name, opts \\ []) do
    name =
      if Keyword.get(opts, :ghostty_naming, false) do
        name
        |> String.split(~r/[-_ ]+/)
        |> Enum.map(&String.capitalize(&1))
        |> Enum.join(" ")
      else
        name
      end

    layer_lines = [
      "background = #{to_hex(r.bg_base)}",
      "foreground = #{to_hex(r.ui_base)}",
      "cursor-color = #{to_hex(r.ui_popped)}",
      "cursor-text = #{to_hex(r.bg_base)}",
      "selection-background = #{to_hex(r.bg_lifted)}",
      "selection-foreground = #{to_hex(r.ui_lifted)}",
      "search-background = #{to_hex(r.diag_good)}",
      "search-foreground = #{to_hex(r.bg_base)}",
      "search-selected-background = #{to_hex(r.diag_great)}",
      "search-selected-foreground = #{to_hex(r.bg_base)}",
      "unfocused-split-fill = #{to_hex(r.bg_base)}",
      "split-divider-color = #{to_hex(r.diag_hint)}"
    ]

    palette_lines =
      Enum.with_index(r.ansi) |> Enum.map(fn {c, i} -> "palette = #{i}=#{to_hex(c)}" end)

    %{
      name => ((palette_lines ++ layer_lines) |> Enum.join("\n")) <> "\n"
    }
  end

  # Custom to_hex to strip the alpha channel.
  defp to_hex(c) do
    with {:ok, c} <- Color.new(c) do
      Color.to_hex(%{c | alpha: nil})
    end
  end
end
