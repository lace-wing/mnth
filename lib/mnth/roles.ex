defmodule Mnth.Roles do
  @moduledoc """
  Role definition and helpers.
  """

  @roles [
    # basic layers
    :bg_muted,
    :bg_base,
    :bg_lifted,
    :ui_muted,
    :ui_base,
    :ui_lifted,
    :ui_popped,

    # dialog
    :diag_info,
    :diag_hint,
    :diag_good,
    :diag_great,
    :diag_warn,
    :diag_error,
    :diag_fatal,

    # semantics
    :sem_keyword,
    :sem_type,
    :sem_func,
    :sem_string,
    :sem_const,
    :sem_regex,
    :sem_comment
  ]

  defstruct @roles ++ [:ansi]

  @type t :: %__MODULE__{
          unquote_splicing(Enum.map(@roles, fn k -> {k, quote(do: Color.t())} end)),
          ansi: [Color.t()]
        }
end
