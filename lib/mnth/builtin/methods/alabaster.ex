defmodule Mnth.Builtin.Methods.Alabaster do
  @moduledoc """
  The Alabaster method.

  # Source
  The Alabaster theme by [Nikita Prokopov (tonsky)](https://github.com/tonsky) and its ports.
  - <https://github.com/tonsky/sublime-scheme-alabaster>
  - <https://github.com/dchinmay2/alabaster.nvim>
  """

  alias Mnth.Palette
  alias Mnth.Roles
  alias Mnth.Method

  @behaviour Method

  @impl true
  def polarities, do: [:dark, :light]

  @impl true
  @spec apply(Palette.t(), polarity: Method.pole()) :: Roles.t()
  def apply(%Palette{} = p, opts \\ []),
    do: roles(p, Palette.Xterm.to_xterm(p.ansi), layers(Keyword.get(opts, :polarity, :dark), p))

  defp layers(:dark, %Palette{} = p) do
    muted = %{bg: p.black, fg: p.dim}
    base = %{bg: p.dark, fg: p.soft}
    lifted = %{bg: p.somber, fg: p.light}
    popped = %{bg: nil, fg: p.white}

    {muted, base, lifted, popped}
  end

  defp layers(:light, %Palette{} = p) do
    muted = %{bg: p.soft, fg: p.dim}
    base = %{bg: p.light, fg: p.somber}
    lifted = %{bg: p.white, fg: p.dark}
    popped = %{bg: nil, fg: p.black}

    {muted, base, lifted, popped}
  end

  defp roles(%Palette{} = p, %Palette.Xterm{} = xp, {muted, base, lifted, popped}) do
    {:ok, info} = Color.Contrast.pick_contrasting(base.bg, [xp.white, xp.black])
    {:ok, hint} = Color.Contrast.pick_contrasting(base.bg, [xp.blue, xp.br_blue])
    {:ok, warn} = Color.Contrast.pick_contrasting(base.bg, [xp.yellow, xp.br_yellow])

    %Roles{
      bg_muted: muted.bg,
      bg_base: base.bg,
      bg_lifted: lifted.bg,
      ui_muted: muted.fg,
      ui_base: base.fg,
      ui_lifted: lifted.fg,
      ui_popped: popped.fg,
      sem_keyword: muted.fg,
      sem_type: base.fg,
      sem_func: lifted.fg,
      sem_const: base.fg,
      sem_string: xp.cyan,
      sem_regex: xp.br_cyan,
      sem_comment: warn,
      diag_info: info,
      diag_hint: hint,
      diag_good: xp.green,
      diag_great: xp.br_green,
      diag_warn: warn,
      diag_error: xp.red,
      diag_fatal: xp.br_red,
      ansi: p.ansi
    }
  end
end
