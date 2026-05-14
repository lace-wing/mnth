defmodule Mnth.Builtin.Targets.Ghostty do
  @moduledoc """
  Target definition for Ghostty.
  """

  @behaviour Mnth.Target

  alias Mnth.Roles

  @impl true
  def render(%Roles{} = r, name, opts \\ []) do
    name =
      if Keyword.get(opts, :ghostty_naming, false) do
        name |> String.replace(~r/[-_ ]+/, " ") |> String.capitalize()
      else
        name
      end

    layer_lines = [
      "background = #{r.bg_base}",
      "foreground = #{r.ui_base}",
      "cursor-color = #{r.ui_popped}",
      "cursor-text = #{r.bg_base}",
      "selection-background = #{r.bg_lifted}",
      "selection-foreground = #{r.ui_lifted}"
    ]

    palette_lines = Enum.map(0..15, fn i -> "palette = #{i}=#{Map.fetch!(r, :"ansi_#{i}")}" end)

    %{
      name => ((palette_lines ++ layer_lines) |> Enum.join("\n")) <> "\n"
    }
  end
end
