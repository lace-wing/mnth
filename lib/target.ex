defmodule Mnth.Target do
  @moduledoc """
  Target definition.
  """

  @type t :: module()

  @typedoc "Render result."
  @type render_result :: %{
          optional(Path.t()) => String.t()
        }

  @doc "Render the target."
  @callback render(r :: Mnth.Roles.t(), name :: String.t()) :: render_result()
end
