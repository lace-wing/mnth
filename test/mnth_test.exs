defmodule MnthTest do
  alias Mnth.Builtin

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

  test "build theme from Theme", %{tmp_dir: tmp_dir} do
    res =
      Mnth.build(Builtin.Themes.HanekawaWhite.get(), Builtin.Targets.Ghostty,
        ghostty_naming: true
      )

    assert Mnth.write_dir(res, tmp_dir) == :ok

    assert File.read!("test/expected/ghostty/Hanekawa") ==
             File.read!(Path.join(tmp_dir, "Hanekawa\ White"))
  end
end
