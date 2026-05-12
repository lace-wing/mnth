defmodule Mnth.Palette do
  @moduledoc """
  Palette definition.
  """

  @colors [
    :black,
    :dark,
    :somber,
    :dim,
    :soft,
    :light,
    :white,

    # ~VIM[exe "norm i:accent_0,\<ESC>yy15pf_l\<C-v>14jg\<C-a>\<ESC>"]
    :accent_0,
    :accent_1,
    :accent_2,
    :accent_3,
    :accent_4,
    :accent_5,
    :accent_6,
    :accent_7,
    :accent_8,
    :accent_9,
    :accent_10,
    :accent_11,
    :accent_12,
    :accent_13,
    :accent_14,
    :accent_15
  ]

  defstruct @colors

  @type t :: %__MODULE__{
          unquote_splicing(Enum.map(@colors, fn k -> {k, quote(do: String.t())} end))
        }

  defmodule Xterm do
    @moduledoc """
    Xterm palette definition and helpers.
    """

    @xterm_colors [
      :black,
      :red,
      :green,
      :yellow,
      :blue,
      :magenta,
      :cyan,
      :white,
      :br_black,
      :br_red,
      :br_green,
      :br_yellow,
      :br_blue,
      :br_magenta,
      :br_cyan,
      :br_white
    ]

    defstruct @xterm_colors

    @type t :: %__MODULE__{
            unquote_splicing(Enum.map(@xterm_colors, fn k -> {k, quote(do: String.t())} end))
          }

    @spec to_xterm(p :: Mnth.Palette.t()) :: Xterm.t()
    def to_xterm(%Mnth.Palette{} = p) do
      fields =
        @xterm_colors
        |> Enum.with_index()
        |> Enum.map(fn {xcolor, i} -> {xcolor, Map.fetch!(p, :"accent_#{i}")} end)

      struct!(Xterm, fields)
    end
  end
end
