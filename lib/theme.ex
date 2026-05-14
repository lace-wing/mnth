defmodule Mnth.Theme do
  @moduledoc """
  Theme definition and helpers.
  """

  alias Mnth.Palette
  alias Mnth.Method

  defstruct [
    :name,
    :palette,
    :method,
    opts: %{}
  ]

  @type t :: %__MODULE__{
          :name => String.t(),
          :palette => Palette.t(),
          :method => Method.t(),
          :opts => keyword()
        }

  @doc """
  ## Return
  The theme.
  """
  @callback get() :: __MODULE__.t()
end
