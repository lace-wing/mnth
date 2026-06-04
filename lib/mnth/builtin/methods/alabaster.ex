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

    [
      ui_roles(polarity, p),
      diag_roles(p),
      sem_roles(polarity, p),
      %{ansi: p.ansi}
    ]
    |> Enum.reduce(fn cur, acc -> merge_nonnil(cur, acc) end)
  end

  defp ui_roles(:dark, %Palette{} = p) do
    %Roles{
      bg_muted: p.black,
      bg_base: p.dark,
      bg_lifted: p.somber,
      ui_muted: p.dim,
      ui_base: p.soft,
      ui_lifted: p.light,
      ui_popped: p.white
    }
  end

  defp ui_roles(:light, %Palette{} = p) do
    %Roles{
      bg_muted: p.soft,
      bg_base: p.light,
      bg_lifted: p.white,
      ui_muted: p.dim,
      ui_base: p.somber,
      ui_lifted: p.dark,
      ui_popped: p.black
    }
  end

  defp sem_roles(:dark, %Palette{} = p) do
    xp = Palette.Xterm.to_xterm(p.ansi)

    %Roles{
      sem_keyword: p.dim,
      sem_type: p.soft,
      sem_func: p.light,
      sem_const: p.soft,
      sem_string: xp.cyan,
      sem_regex: xp.br_cyan,
      sem_comment: xp.br_yellow
    }
  end

  defp sem_roles(:light, %Palette{} = p) do
    xp = Palette.Xterm.to_xterm(p.ansi)

    %Roles{
      sem_keyword: p.dim,
      sem_type: p.somber,
      sem_func: p.dark,
      sem_const: p.somber,
      sem_string: xp.cyan,
      sem_regex: xp.br_cyan,
      sem_comment: xp.yellow
    }
  end

  defp diag_roles(%Palette{} = p) do
    xp = Palette.Xterm.to_xterm(p.ansi)

    %Roles{
      diag_info: xp.white,
      diag_hint: xp.blue,
      diag_good: xp.green,
      diag_great: xp.br_green,
      diag_warn: xp.yellow,
      diag_error: xp.red,
      diag_fatal: xp.br_red
    }
  end

  defp merge_nonnil(map1, map2),
    do: Map.merge(map1, map2, fn _key, val1, val2 -> val1 || val2 end)
end
