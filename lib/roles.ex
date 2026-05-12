defmodule Mnth.Roles do
  @moduledoc """
  Role definition and helpers.
  """

  @ansi_roles [
    # ~VIM[exe "norm i:ansi_0,\<ESC>yy15pf_l\<C-v>14jg\<C-a>\<ESC>"]
    :ansi_0,
    :ansi_1,
    :ansi_2,
    :ansi_3,
    :ansi_4,
    :ansi_5,
    :ansi_6,
    :ansi_7,
    :ansi_8,
    :ansi_9,
    :ansi_10,
    :ansi_11,
    :ansi_12,
    :ansi_13,
    :ansi_14,
    :ansi_15
  ]

  @roles [
           # basic gradients
           :bg_muted,
           :bg_base,
           :bg_lifted,
           :ui_muted,
           :ui_base,
           :ui_lifted,
           :ui_popped,

           # dialog
           :diag_hint,
           :diag_info,
           :diag_warn,
           :diag_error,

           # semantics
           :sem_main,
           :sem_alt,
           :sem_keyword,
           :sem_func,
           :sem_string,
           :sem_const,
           :sem_regex,
           :sem_comment
         ] ++ @ansi_roles

  defstruct @roles

  @type t :: %__MODULE__{
          unquote_splicing(Enum.map(@roles, fn k -> {k, quote(do: String.t())} end))
        }

  @spec ansi_roles(p :: Mnth.Palette.t()) :: %{
          unquote_splicing(Enum.map(@ansi_roles, fn k -> {k, quote(do: String.t())} end))
        }
  def ansi_roles(%Mnth.Palette{} = p) do
    @ansi_roles
    |> Enum.with_index()
    |> Map.new(fn {ansi, i} -> {ansi, Map.fetch!(p, :"accent_#{i}")} end)
  end
end
