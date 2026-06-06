defmodule Mnth.CLI do
  @moduledoc """
  Command-line interface for Mnth.
  """

  def main(argv) do
    Optimus.new!(
      name: "mnth",
      description: "MNTH (name subject to changes)",
      version: "0.1.0",
      author: "Lacewing",
      about: "Utility for theming.",
      allow_unknown_args: false,
      parse_double_dash: true,
      flags: [
        verbosity: [
          short: "-v",
          help: "Verbosity level",
          multiple: true,
          global: true
        ]
      ],
      options: [
        theme: [
          value_name: "THEME",
          short: "-n",
          long: "--theme",
          help: "Theme name or file.",
          required: true,
          global: true
        ],
        targets: [
          value_name: "TARGETS",
          short: "-t",
          long: "--targets",
          help: "Target names or files.",
          multiple: true,
          required: true,
          global: true
        ]
      ],
      subcommands: [
        compile: [
          name: "compile",
          about: "Compile a theme."
        ],
        watch: [
          name: "watch",
          about: "Watch files of a theme, compile on change."
        ]
      ]
    )
    |> Optimus.parse!(argv)
    |> IO.inspect()
  end
end
