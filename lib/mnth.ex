defmodule Mnth do
  @moduledoc """
  MNTH wrapping functions.
  """

  alias Mnth.Theme
  alias Mnth.Target

  @doc """
  Build a theme.

  ## Parameters
  - theme: Theme to use.
  - opts: Options for `target.render`

  ## Returns
  A map from relative file paths to their content.
  """
  @spec build(theme :: Theme.t(), target :: Target.t(), opts :: keyword()) ::
          {:ok, Target.file_map()} | {:error, String.t()}
  def build(theme, target, opts \\ []) do
    with {:ok, t} <- Theme.resolve(theme),
         {:ok, target} <- get_mod(target, Target) do
      {
        :ok,
        t.method.apply!(t.palette.get!(), t.opts) |> target.render!(t.name, opts)
      }
    end
  end

  @doc """
  Write mapped files into a directory.
  """
  @spec write(res :: Target.file_map(), dir :: Path.t()) :: :ok | {:error, String.t()}
  def write(res, dir) do
    if not File.dir?(dir) do
      {:error, "#{dir} is not a directory"}
    else
      Enum.each(res, fn {file, text} -> File.write!(Path.join(dir, file), text) end)
    end
  end

  @doc """
  Checks if `mod` implements `behaviour`
  """
  @spec behaves?(mod :: atom(), behaviour :: atom()) :: boolean()
  def behaves?(mod, behaviour) do
    Code.ensure_loaded?(mod) and
      behaviour in Keyword.get(mod.__info__(:attributes), :behaviour, [])
  end

  @doc """
  Get `mod` if it implements `behaviour`
  If `mod` is a file, load the file and find the first implementing module.
  """
  @spec get_mod(mod :: atom(), behaviour :: atom()) :: {:ok, atom()} | {:error, String.t()}
  def get_mod(mod, behaviour) when is_atom(mod) do
    if behaves?(mod, behaviour) do
      {:ok, mod}
    else
      {:error, "#{mod} does not implement #{behaviour}"}
    end
  end

  @spec get_mod(path :: Path.t(), behaviour :: atom()) :: {:ok, atom()} | {:error, String.t()}
  def get_mod(path, behaviour) when is_binary(path) do
    old_comp_opts = Code.compiler_options()

    try do
      Code.compiler_options(ignore_module_conflict: true)
      mods = Code.compile_file(path) |> Enum.map(fn {mod, _bin} -> mod end)

      case Enum.find(mods, &behaves?(&1, behaviour)) do
        nil -> {:error, "#{path} does not contain module that implements #{behaviour}"}
        mod -> {:ok, mod}
      end
    after
      Code.compiler_options(old_comp_opts)
    end
  end
end
