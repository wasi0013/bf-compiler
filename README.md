# Bfc

![Elixir CI](https://github.com/wasi0013/bfc/workflows/Elixir%20CI/badge.svg?branch=master)

Brainfuck Compiler written in Elixir

# Compile

 - Clone this repository.
 - Check all the tests are passing by running `mix test`
 - Generate an executable by running the command: `mix escript.build`
 - The above command should generate an executable named `bfc`
 
# Run

  `./bfc <path of brainfuck source code>`
  
  **example:**
  `./bfc test/fixtures/test_code.bf`
  
# Try it using REPL

 - type `iex -S mix` in the project folder
 - Execute a brainfuck code using: `Bfc.Compiler.execute("BF CODE")`
 - Compile a brainfuck source code: `Bfc.Compiler.compile("path/to/source.bf")`

**Example:**  

```
{_,_, output} = Bfc.Compiler.execute("+++++++++++>+>>>>++++++++++++++++++++++++++++++++++++++++++++>++++++++++++++++++++++++++++++++<<<<<<[>[>>>>>>+>+<<<<<<<-]>>>>>>>[<<<<<<<+>>>>>>>-]<[>++++++++++[-<-[>>+>+<<<-]>>>[<<<+>>>-]+<[>[-]<[-]]>[<<[>>>+<<<-]>>[-]]<<]>>>[>>+>+<<<-]>>>[<<<+>>>-]+<[>[-]<[-]]>[<<+>>[-]]<<<<<<<]>>>>>[++++++++++++++++++++++++++++++++++++++++++++++++.[-]]++++++++++<[->-<]>++++++++++++++++++++++++++++++++++++++++++++++++.[-]<<<<<<<<<<<<[>>>+>+<<<<-]>>>>[<<<<+>>>>-]<-[>>.>.<<<[-]]<<[>>+>+<<<-]>>>[<<<+>>>-]<<[<+>-]>[<+>-]<<<-]")
```
```
output
"1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89"
```



## Installation as a Package

The package can be installed from github by adding `bfc` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:bfc, git: "https://github.com/wasi0013/bfc.git"}
  ]
end
```
