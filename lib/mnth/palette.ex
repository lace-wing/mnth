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
  ## Return
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

    @doc """
    Map 16 ANSI colors to XTERM convention colors.

    ## Parameters
    - ansi_colors: The ANSI colors.

    ## Return
    The XTERM palette.
    """
    @spec to_xterm(ansi_colors :: [Color.t()]) :: Xterm.t()
    def to_xterm(ansi_colors) do
      struct!(Xterm, Enum.zip(@xterm_colors, ansi_colors))
    end
  end
end
