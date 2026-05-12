defmodule Mnth.Method.Alabaster do
  @behaviour Mnth.Method

  alias Mnth.{Palette, Roles}

  @impl true
  def polarities, do: [:dark, :light]

  @impl true
  def apply(:dark, %Palette{} = p) do
    %Roles{
      bg_muted: p.black,
      bg_base: p.dark,
      bg_lifted: p.somber,
      ui_muted: p.dim,
      ui_base: p.soft,
      ui_lifted: p.light,
      ui_popped: p.white
    }
    |> merge_nonnil(common_roles(p))
  end

  @impl true
  def apply(:light, %Palette{} = p) do
    %Roles{
      bg_muted: p.soft,
      bg_base: p.light,
      bg_lifted: p.white,
      ui_muted: p.dim,
      ui_base: p.somber,
      ui_lifted: p.dark,
      ui_popped: p.black
    }
    |> merge_nonnil(common_roles(p))
  end

  defp common_roles(%Palette{} = p),
    do:
      [diag_roles(p), sem_roles(p), Roles.ansi_roles(p)]
      |> Enum.reduce(fn cur, acc -> merge_nonnil(cur, acc) end)

  defp diag_roles(%Palette{} = p) do
    xp = Palette.Xterm.to_xterm(p)

    %Roles{
      diag_hint: xp.white,
      diag_info: xp.br_white,
      diag_warn: xp.br_yellow,
      diag_error: xp.br_red
    }
  end

  defp sem_roles(%Palette{} = p) do
    xp = Palette.Xterm.to_xterm(p)

    %Roles{
      sem_main: p.soft,
      sem_alt: xp.white,
      sem_comment: xp.br_yellow,
      sem_const: xp.magenta,
      sem_string: xp.cyan,
      sem_regex: xp.br_cyan,
      sem_keyword: p.dim,
      sem_func: p.light
    }
  end

  defp merge_nonnil(map1, map2), do: Map.merge(map1, map2, fn _key, val1, val2 -> val1 || val2 end)
end
