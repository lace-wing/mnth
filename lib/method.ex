defmodule Mnth.Method do
  @moduledoc """
  Coloring method definition.
  """

  @type t :: module()

  @typedoc "Theme polarity."
  @type pole :: :light | :dark

  @doc "Returns supported polarities."
  @callback polarities() :: [pole()]

  @doc "Applies the method for a polarity."
  @callback apply(polarity :: pole(), palette :: Mnth.Palette.t()) :: Mnth.Roles.t()
end
