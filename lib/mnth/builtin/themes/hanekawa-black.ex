defmodule Mnth.Builtin.Themes.HanekawaBlack do
  @moduledoc """
  The Hanekawa Black theme, for light mode.
  """

  @behaviour Mnth.Theme

  @impl true
  def get!(),
    do: %Mnth.Theme{
      name: "hanekawa-black",
      palette: Mnth.Builtin.Palettes.HanekawaBlack,
      method: Mnth.Builtin.Methods.Alabaster,
      opts: [polarity: :light]
    }
end
