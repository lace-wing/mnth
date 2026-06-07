defmodule Mnth.Builtin.Themes.HanekawaWhite do
  @moduledoc """
  The Hanekawa White theme, for dark mode.
  """

  @behaviour Mnth.Theme

  @impl true
  def get!(),
    do: %Mnth.Theme{
      name: "hanekawa-white",
      palette: Mnth.Builtin.Palettes.HanekawaWhite,
      method: Mnth.Builtin.Methods.Alabaster,
      opts: [polarity: :dark]
    }
end
