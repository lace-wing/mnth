defmodule Mnth.Palette do
  @moduledoc """
  Palette definition.
  """

  @gradients [
    :black,
    :dark,
    :somber,
    :dim,
    :soft,
    :light,
    :white
  ]

  defstruct @gradients ++ [:ansi]

  @type t :: %__MODULE__{
          unquote_splicing(Enum.map(@gradients, fn k -> {k, quote(do: Color.t())} end)),
          ansi: [Color.t()]
        }

  @doc """
  ## Returns
  The palette.
  """
  @callback get() :: __MODULE__.t()

  @doc """
  Get palette from a TOML file.

  ## Parameters
  - file: The TOML file.

  ## Return
  The palette.
  """
  @spec from_toml(file :: Path.t()) :: __MODULE__.t()
  def from_toml(_file) do
    raise "not implemented"
  end

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
            unquote_splicing(Enum.map(@xterm_colors, fn k -> {k, quote(do: Color.t())} end))
          }

    @spec to_xterm(p :: Mnth.Palette.t()) :: Xterm.t()
    def to_xterm(%Mnth.Palette{} = p) do
      struct!(Xterm, Enum.zip(@xterm_colors, p.ansi))
    end
  end
end
