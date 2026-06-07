defmodule Mnth.Target do
  @moduledoc """
  Target definition.
  """

  @type t :: module()

  @typedoc """
  Flat map from path to content.
  """
  @type file_map :: %{
          optional(Path.t()) => String.t()
        }

  @doc """
  Render the target.

  ## Parameters
  - roles: Roles.
  - name: Name of a theme.
  - opts: Options.

  ## Returns
  A map from relative file path to file content.
  """
  @callback render!(roles :: Mnth.Roles.t(), name :: String.t(), opts :: keyword()) :: file_map()
end
