# Cldr for Territories

[![CircleCI](https://circleci.com/gh/Schultzer/cldr_territories.svg?style=svg)](https://circleci.com/gh/Schultzer/cldr_territories)

## Introduction and Getting Started

`ex_cldr_territories` is an add-on library for [ex_cldr](https://hex.pm/packages/ex_cldr) that provides localization for territories.


## Examples

```elixir
iex> Cldr.Territory.from_territory_code(:GB)
{:ok, "United Kingdom"}

iex> Cldr.Territory.translate_territory("Reino Unido", "pt", "en")
{:ok, "UK"}

iex> Cldr.Territory.contains?(:EU, :GB)
true

iex> Cldr.Territory.parent(:GB)
{:ok, [:"154", :EU, :UN]}

iex> Cldr.Territory.children(:EU)
{:ok,
 [:AT, :BE, :CY, :CZ, :DE, :DK, :EE, :ES, :FI, :FR, :GB, :GR, :HR, :HU, :IE,
  :IT, :LT, :LU, :LV, :MT, :NL, :PL, :PT, :SE, :SI, :SK, :BG, :RO]}

iex> Cldr.Territory.info(:GB)
{:ok,
 %{currency: [GBP: %{from: ~D[1694-07-27]}], gdp: 2788000000000,
   language_population: %{"bn" => %{population_percent: 0.67},
     "cy" => %{official_status: "official_regional", population_percent: 0.77},
     "de" => %{population_percent: 6}, "el" => %{population_percent: 0.34},
     "en" => %{official_status: "official", population_percent: 99},
     "fr" => %{population_percent: 19},
     "ga" => %{official_status: "official_regional", population_percent: 0.026},
     "gd" => %{official_status: "official_regional", population_percent: 0.099,
       writing_percent: 5}, "it" => %{population_percent: 0.34},
     "ks" => %{population_percent: 0.19}, "kw" => %{population_percent: 0.0031},
     "ml" => %{population_percent: 0.035}, "pa" => %{population_percent: 0.79},
     "sco" => %{population_percent: 2.7, writing_percent: 5},
     "syl" => %{population_percent: 0.51}, "yi" => %{population_percent: 0.049},
     "zh-Hant" => %{population_percent: 0.54}}, literacy_percent: 99,
   measurement_system: "UK", paper_size: "A4", population: 64769500,
   telephone_country_code: 44, temperature_measurement: "metric"}}

iex> Cldr.Territory.to_unicode_flag(:US)
{:ok, "🇺🇸"}

iex> Cldr.Territory.to_currency_code(:US)
{:ok, :USD}
```

For help in `iex`:

```elixir
iex> h Cldr.Territory.from_territory_code
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
        {:ex_cldr_territories, "~> 1.1"}
      ]
    end
```

then retrieve `ex_cldr_territories` from [hex](https://hex.pm/packages/ex_cldr_territories):

    mix deps.get
    mix deps.compile


## LICENSE

(The MIT License)

Copyright (c) 2017 Benjamin Schultzer

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
