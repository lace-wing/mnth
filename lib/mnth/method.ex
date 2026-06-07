defmodule Mnth.Method do
  @moduledoc """
  Coloring method definition.
  """

  @typedoc "Theme polarity."
  @type pole :: :light | :dark

  @doc """
  ## Return
  Supported polarities.
  """
  @callback polarities() :: [pole()]

  @doc """
  Applies the method for a polarity.

  ## Parameters
  - palette: Palette to use.
  - opts: Options, like polarity.

  ## Return
  Roles for colors in the palette.
  """
  @callback apply!(palette :: Mnth.Palette.t(), opts :: keyword()) ::
              Mnth.Roles.t()
end
