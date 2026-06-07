defmodule Mnth.Theme do
  @moduledoc """
  Theme definition and helpers.
  """

  import Mnth, only: [get_mod: 2, behaves?: 2]
  alias Mnth.Palette
  alias Mnth.Method

  defstruct [
    :name,
    :palette,
    :method,
    opts: []
  ]

  @type t :: %__MODULE__{
          :name => String.t(),
          :palette => module(),
          :method => module(),
          :opts => keyword()
        }

  @doc """
  ## Return
  The theme.
  """
  @callback get!() :: __MODULE__.t()

  @doc """
  Ensure required modules are loaded and implements correct behaviour.
  If `mod` is a module, checks if it implements `#{__MODULE__}` first.
  """
  @spec resolve(theme :: __MODULE__.t()) :: {:ok, __MODULE__.t()} | {:error, String.t()}
  def resolve(%__MODULE__{} = t) when is_struct(t, __MODULE__) do
    with {:ok, palette} <- get_mod(t.palette, Palette),
         {:ok, method} <- get_mod(t.method, Method) do
      {
        :ok,
        %__MODULE__{
          name: t.name,
          palette: palette,
          method: method,
          opts: t.opts
        }
      }
    end
  end

  @spec resolve(theme :: module()) :: {:ok, __MODULE__.t()} | {:error, String.t()}
  def resolve(t) when is_atom(t) do
    if behaves?(t, __MODULE__) do
      resolve(t.get!())
    else
      {:error, "#{t} does not implement #{__MODULE__}"}
    end
  end
end
