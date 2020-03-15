# Bfc

![Elixir CI](https://github.com/wasi0013/bfc/workflows/Elixir%20CI/badge.svg?branch=master)

Brainfuck Compiler written in Elixir

# Compile

 - Clone this repository.
 - Check all the tests are passing by running `mix test`
 - Generate an executable by running the command: `mix escript.build`
 - The above command should generate an executable named `bfc`
 
# Run

  `./bfc /path/to/bf/source_code.bf`

## Installation as a Package

The package can be installed from github by adding `bfc` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:bfc, git: "https://github.com/wasi0013/bfc.git"}
  ]
end
```
