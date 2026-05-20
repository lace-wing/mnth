defmodule Mnth.Target do
  @moduledoc """
  Target definition.
  """

  @type t :: module()

  @typedoc "Render result."
  @type render_result :: %{
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
  @callback render(roles :: Mnth.Roles.t(), name :: String.t(), opts :: keyword()) :: render_result()
end
