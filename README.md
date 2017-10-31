# Cldr for Territories

## Introduction and Getting Started

`ex_cldr_territories` is an add-on library for [ex_cldr](https://hex.pm/packages/ex_cldr) that provides localization for territories.


## Examples

```elixir
iex> Cldr.Territory.from_territory_code(:GB)
{:ok, "United Kingdom"}

iex> Cldr.Territory.translate_territory("Reino Unido", "pt", "en")
{:ok, "United Kingdom"}

iex> Cldr.Territory.parent(:GB)
{:ok, [:"154", :EU, :UN]}

iex> Cldr.Territory.contians(:EU)
{:ok,
 [:AT, :BE, :CY, :CZ, :DE, :DK, :EE, :ES, :FI, :FR, :GB, :GR, :HR, :HU, :IE,
  :IT, :LT, :LU, :LV, :MT, :NL, :PL, :PT, :SE, :SI, :SK, :BG, :RO]}

iex> Cldr.Territory.info(:GB)
{:ok,
 %{gdp: "2788000000000",
   language_population: %{bn: %{population_percent: "0.67"},
     cy: %{official_status: "official_regional", population_percent: "0.77"},
     de: %{population_percent: "6"}, el: %{population_percent: "0.34"},
     en: %{official_status: "official", population_percent: "99"},
     fr: %{population_percent: "19"},
     ga: %{official_status: "official_regional", population_percent: "0.026"},
     gd: %{official_status: "official_regional", population_percent: "0.099",
       writing_percent: "5"}, it: %{population_percent: "0.34"},
     ks: %{population_percent: "0.19"}, kw: %{population_percent: "0.0031"},
     ml: %{population_percent: "0.035"}, pa: %{population_percent: "0.79"},
     sco: %{population_percent: "2.7", writing_percent: "5"},
     syl: %{population_percent: "0.51"}, yi: %{population_percent: "0.049"},
     zh_Hant: %{population_percent: "0.54"}}, literacy_percent: "99",
   population: "64430400"}}
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
        {:ex_cldr_territories, "~> 0.0.1"}
      ]
    end
```

then retrieve `ex_cldr_territories` from [hex](https://hex.pm/packages/ex_cldr_territories):

    mix deps.get
    mix deps.compile
