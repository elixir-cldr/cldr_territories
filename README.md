# Cldr for Territories

![main](https://github.com/elixir-cldr/cldr_territories/actions/workflows/ci.yml/badge.svg?branch=main)

## Introduction and Getting Started

`ex_cldr_territories` is an add-on library for [ex_cldr](https://hex.pm/packages/ex_cldr) that provides localization for territories.

## Examples

```elixir
iex> MyCldr.Territory.from_territory_code(:GB)
{:ok, "United Kingdom"}

iex> MyCldr.Territory.to_territory_code("United Kingdom", "en")
{:ok, :GB}

iex> MyCldr.Territory.translate_territory("Reino Unido", "pt", "en")
{:ok, "UK"}

iex> MyCldr.Territory.contains?(:EU, :GB)
false

iex> MyCldr.Territory.contains?(:EU, :DE)
true

iex> MyCldr.Territory.parent(:GB)
{:ok, [:"154", :UN]}

iex> MyCldr.Territory.children(:EU)
{:ok,
 [:AT, :BE, :CY, :CZ, :DE, :DK, :EE, :ES, :FI, :FR, :GR, :HR, :HU, :IE,
  :IT, :LT, :LU, :LV, :MT, :NL, :PL, :PT, :SE, :SI, :SK, :BG, :RO]}

iex> MyCldr.Territory.info(:GB)
{:ok,
 %{
   currency: [GBP: %{from: ~D[1694-07-27]}],
   gdp: 2925000000000,
   language_population: %{
     "bn" => %{population_percent: 0.67},
     "cy" => %{official_status: "official_regional", population_percent: 0.77},
     "de" => %{population_percent: 6},
     "el" => %{population_percent: 0.33},
     "en" => %{official_status: "official", population_percent: 99},
     "fr" => %{population_percent: 19},
     "ga" => %{official_status: "official_regional", population_percent: 0.026},
     "gd" => %{
       official_status: "official_regional",
       population_percent: 0.099,
       writing_percent: 5
     },
     "it" => %{population_percent: 0.33},
     "ks" => %{population_percent: 0.19},
     "kw" => %{population_percent: 0.003},
     "ml" => %{population_percent: 0.035},
     "pa" => %{population_percent: 0.79},
     "sco" => %{population_percent: 2.7, writing_percent: 5},
     "syl" => %{population_percent: 0.51},
     "yi" => %{population_percent: 0.049},
     "zh-Hant" => %{population_percent: 0.54}
   },
   literacy_percent: 99,
   measurement_system: %{
     default: :uksystem,
     paper_size: :a4,
     temperature: :uksystem
   },
   population: 65761100
 }}

iex> MyCldr.Territory.to_unicode_flag(:US)
{:ok, "🇺🇸"}

iex> MyCldr.Territory.to_currency_code(:US)
{:ok, :USD}
```

For help in `iex`:

```elixir
iex> h MyCldr.Territory.from_territory_code
```

## Documentation

[hex documentation for ex_cldr](https://hexdocs.pm/ex_cldr/)

[hex documentation for ex_cldr_territories](https://hexdocs.pm/ex_cldr_territories/)

## Installation

Note that `:ex_cldr_territories` requires Elixir 1.12 or later.

Add `ex_cldr_territories` as a dependency to your `mix` project:

```elixir
    defp deps do
      [
        {:ex_cldr_territories, "~> 2.10.0"}
      ]
    end
```

then retrieve `ex_cldr_territories` from [hex](https://hex.pm/packages/ex_cldr_territories):

    mix deps.get
    mix deps.compile

In order to use this library, a backend module for `ex_cldr` must be defined.  This is described in full in the `ex_cldr` [readme](https://hexdocs.pm/ex_cldr/readme.html#configuration).
To get started, define a backend module in your project as follows:

```elixir
defmodule MyApp.Cldr do
  use Cldr,
    locales: [:en],
    providers: [Cldr.Territory]
end
```

## LICENSE

(The MIT License)

Copyright (c) 2017 Benjamin Schultzer

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
