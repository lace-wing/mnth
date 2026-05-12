defmodule Mnth.Theme do
  @moduledoc """
  Theme definition and helpers.
  """

  alias Mnth.{Theme, Palette, Method, Target}

  defstruct [
    :name,
    :palette,
    :method,
    :target,
    :polarity
  ]

  @type t :: %__MODULE__{
          :name => String.t(),
          :palette => Palette.t(),
          :method => Method.t(),
          :target => Target.t(),
          :polarity => Method.pole()
        }

  @doc "Build a theme."
  @spec build(
          palette :: Palette.t(),
          method :: Method.t(),
          target :: Target.t(),
          name :: String.t(),
          polarity :: Method.pole()
        ) :: Target.render_result()
  def build(palette, method, target, name, polarity) do
    method.apply(polarity, palette) |> target.render(name)
  end

  @spec build(theme :: Theme.t()) :: Target.render_result()
  def build(theme) do
    %Theme{name: name, palette: palette, method: method, target: target, polarity: polarity} =
      theme

    build(palette, method, target, name, polarity)
  end

  @spec write(res :: Target.render_result(), dir :: Path.t()) :: :ok | {:error, term()}
  def write(res, dir) do
    if not File.dir?(dir) do
      raise ArgumentError, "#{dir} is not a directory!"
    end

    Enum.each(res, fn {rel_path, text} -> File.write!(Path.join(dir, rel_path), text) end)
  end
end
