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
  def apply(%Palette{} = p, opts \\ []) do
    polarity = Keyword.get(opts, :polarity, :dark)

    %{
      roles(polarity, p)
      | ansi: p.ansi
    }
  end

  defp roles(:dark, %Palette{} = p) do
    xp = Palette.Xterm.to_xterm(p.ansi)

    muted = %{
      bg: p.black,
      fg: p.dim
    }

    base = %{
      bg: p.dark,
      fg: p.soft
    }

    lifted = %{
      bg: p.somber,
      fg: p.light
    }

    {:ok, warn} = Color.Contrast.pick_contrasting(base.bg, [xp.yellow, xp.br_yellow])

    %Roles{
      bg_muted: muted.bg,
      bg_base: base.bg,
      bg_lifted: lifted.bg,
      ui_muted: muted.fg,
      ui_base: base.fg,
      ui_lifted: lifted.fg,
      ui_popped: p.white,
      sem_keyword: muted.fg,
      sem_type: base.fg,
      sem_func: lifted.fg,
      sem_const: base.fg,
      sem_string: xp.cyan,
      sem_regex: xp.br_cyan,
      sem_comment: warn,
      diag_info: xp.white,
      diag_hint: xp.br_blue,
      diag_good: xp.green,
      diag_great: xp.br_green,
      diag_warn: warn,
      diag_error: xp.red,
      diag_fatal: xp.br_red
    }
  end

  defp roles(:light, %Palette{} = p) do
    xp = Palette.Xterm.to_xterm(p.ansi)

    muted = %{
      bg: p.soft,
      fg: p.dim
    }

    base = %{
      bg: p.light,
      fg: p.somber
    }

    lifted = %{
      bg: p.white,
      fg: p.dark
    }

    {:ok, warn} = Color.Contrast.pick_contrasting(base.bg, [xp.yellow, xp.br_yellow])

    %Roles{
      bg_muted: muted.bg,
      bg_base: base.bg,
      bg_lifted: lifted.bg,
      ui_muted: muted.fg,
      ui_base: base.fg,
      ui_lifted: lifted.fg,
      ui_popped: p.black,
      sem_keyword: muted.fg,
      sem_type: base.fg,
      sem_func: lifted.fg,
      sem_const: base.fg,
      sem_string: xp.cyan,
      sem_regex: xp.br_cyan,
      sem_comment: warn,
      diag_info: xp.black,
      diag_hint: xp.blue,
      diag_good: xp.green,
      diag_great: xp.br_green,
      diag_warn: warn,
      diag_error: xp.red,
      diag_fatal: xp.br_red
    }
  end
end
