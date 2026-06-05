defmodule Mnth do
  @moduledoc """
  Documentation for `Mnth`.
  """

  alias Mnth.Theme
  alias Mnth.Target

  @doc """
  Build a theme.

  ## Parameters
  - theme: Theme to use.
  - opts: Options for `target.render`.

  ## Returns
  A map from relative file paths to their content.
  """
  @spec build(theme :: Theme.t(), target :: Target.t(), opts :: keyword()) ::
          Target.file_map()
  def build(theme, target, opts) do
    %Theme{name: name, palette: palette, method: method, opts: method_opts} = theme
    method.apply(palette, method_opts) |> target.render(name, opts)
  end

  @doc "Write files into a directory."
  @spec write(res :: Target.file_map(), dir :: Path.t()) :: :ok | {:error, term()}
  def write(res, dir) do
    if not File.dir?(dir) do
      raise ArgumentError, "#{dir} is not a directory!"
    end

    Enum.each(res, fn {file, text} -> File.write!(Path.join(dir, file), text) end)
  end
end
