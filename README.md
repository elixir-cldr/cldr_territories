# Cldr for Territories

## Introduction and Getting Started

`ex_cldr_territories` is an addon library for [ex_cldr](https://hex.pm/packages/ex_cldr) that provides localization for territories.


## Examples

```elixir
iex> Cldr.Territory.from_territory(:gb)
"UK"

iex> Cldr.Territory.translate("Reino Unido", :pt)
"UK"
```

For help in `iex`:

```elixir
iex> h Cldr.Territory.from_territory
```

## Documentation

[hex documentation for ex_cldr](https://hexdocs.pm/ex_cldr/)

[hex documentation for ex_cldr_territories](https://hexdocs.pm/ex_cldr_territories/)

## Installation

Note that `:ex_cldr_territories` requires Elixir 1.5 or later.

Add `ex_cldr_territories` as a dependency to your `mix` project:

```elixir
    defp deps do
      [
        {:ex_cldr_territories, "~> 0.0.1"}
      ]
    end
```

then retrieve `ex_cldr_territories` from [hex](https://hex.pm/packages/ex_cldr_territories):

    mix deps.get
    mix deps.compile
