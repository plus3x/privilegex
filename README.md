# Setuid

**TODO: Add description**

## Make

[Instruction](http://andrealeopardi.com/posts/using-c-from-elixir-with-nifs)

Compile C:
```bash
$ cc -fPIC -I$(ERL_INCLUDE_PATH) -dynamiclib -undefined dynamic_lookup -o ./src/setuid.so ./src/setuid.c
```
ERL_INCLUDE_PATH - path to "include" directory contains "erl_nif.h"

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `setuid` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:setuid, "~> 0.1.0"}]
    end
    ```

  2. Ensure `setuid` is started before your application:

    ```elixir
    def application do
      [applications: [:setuid]]
    end
    ```

