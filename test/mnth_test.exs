defmodule MnthTest do
  alias Mnth.{Method, Targets, Theme}
  use ExUnit.Case
  doctest Mnth

  setup do
    tmp_dir =
      Path.expand(
        "tmp/#{Path.basename(__ENV__.file, ".exs")}-#{System.unique_integer([:positive])}"
      )

    File.mkdir_p!(tmp_dir)

    on_exit(fn ->
      File.rm_rf!(tmp_dir)
    end)

    %{tmp_dir: tmp_dir}
  end

  test "build theme", %{tmp_dir: tmp_dir} do
    {p_hanekawa, _binding} = Code.eval_file("palettes/hanekawa.exs")

    m_alabaster =
      Code.compile_file("methods/alabaster.exs")
      |> Enum.map(fn {mod, _bin} -> mod end)
      |> Enum.find(fn mod ->
        mod.__info__(:attributes)
        |> Keyword.get(:behaviour, [])
        |> then(fn attrs -> Method in attrs end)
      end)

    res = Theme.build(p_hanekawa, m_alabaster, Targets.Ghostty, "hanekawa", :dark)

    assert Mnth.write(res, tmp_dir) == :ok

    assert File.read!("test/expected/ghostty/Hanekawa") == File.read!(Path.join(tmp_dir, "Hanekawa"))
  end
end
