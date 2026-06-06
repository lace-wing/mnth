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

  test "build Hanekawa for Ghostty", %{tmp_dir: tmp_dir} do
    hw =
      Mnth.build(Builtin.Themes.HanekawaWhite.get(), Builtin.Targets.Ghostty,
        ghostty_naming: true
      )

    hb =
      Mnth.build(Builtin.Themes.HanekawaBlack.get(), Builtin.Targets.Ghostty,
        ghostty_naming: true
      )

    assert Mnth.write(hw, tmp_dir) == :ok

    assert Mnth.write(hb, tmp_dir) == :ok

    assert File.read!("test/expected/ghostty/Hanekawa\ White") ==
             File.read!(Path.join(tmp_dir, "Hanekawa\ White"))

    assert File.read!("test/expected/ghostty/Hanekawa\ Black") ==
             File.read!(Path.join(tmp_dir, "Hanekawa\ Black"))
  end
end
