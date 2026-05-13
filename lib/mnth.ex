defmodule Mnth do
  @moduledoc """
  Documentation for `Mnth`.
  """

  alias Mnth.{Target}

  @doc "Write files into a directory."
  @spec write(res :: Target.render_result(), dir :: Path.t()) :: :ok | {:error, term()}
  def write(res, dir) do
    if not File.dir?(dir) do
      raise ArgumentError, "#{dir} is not a directory!"
    end

    Enum.each(res, fn {file, text} -> File.write!(Path.join(dir, file), text) end)
  end
end
