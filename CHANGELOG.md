# Changelog

## Cldr Territories v2.9.0 Apr TBD, 2024

### Enhancements

* Updates to support [CLDR release 45](https://cldr.unicode.org/index/downloads/cldr-45) via [ex_cldr version 2.38](https://hex.pm/packages/ex_cldr/2.38.0)
* Fixed typespec in `info/1` and `info!/1`, thanks to @jfpedroza.
* Fixed typespec in `known_territory_subdivision/0`, thanks to @richard-ash.
* Fixed compiler warnings for Elixir 1.16, thanks to @tomciopp.
* Require Elixir 1.12.0.

## Cldr Territories v2.8.1 July 18, 2023

### Enhancements

* Fixed compiler warning for `from_subdivision_code/*`.

## Cldr Territories v2.8.0 July 15, 2023

### Enhancements

* Fixed compiler warnings for Elixir 1.15, thanks to @alappe.
* Resolve subdivision aliases in `from_subdivision_code/*` and `from_subdivision_code!/*` and,
  allow optional style to be passed to the underlying `from_territory_code/*` in cases where a subdivision is to be treated as a territory.
* Added `subdivision_aliases/0`.

## Cldr Territories v2.7.0 May 5, 2023

### Enhancements

* Updates to support [CLDR release 43](https://cldr.unicode.org/index/downloads/cldr-43) via [ex_cldr version 2.37](https://hex.pm/packages/ex_cldr/2.37.0)


## Cldr Territories v2.6.0 January 14, 2023

### Enhancements

* Updates to support [CLDR release 42](https://cldr.unicode.org/index/downloads/cldr-42) via [ex_cldr version 2.34](https://hex.pm/packages/ex_cldr/2.34.0)

## Cldr Territories v2.5.0 Octorber 24, 2022

### Enhancements

* Updates to [ex_cldr version 2.33](https://hex.pm/packages/ex_cldr/2.33.0)
* Updates to support [CLDR release 41](https://cldr.unicode.org/index/downloads/cldr-41) via [ex_cldr version 2.28](https://hex.pm/packages/ex_cldr/2.28.0)

## Cldr Territories v2.4.1 Octorber 20nd, 2022

### Enhancements

* Fixed spec for `known_territory_subdivisions/2` thanks to @zorbash

## Cldr Territories v2.4.0 February 22nd, 2022

### Enhancements

* Updates to [ex_cldr version 2.26.0](https://hex.pm/packages/ex_cldr/2.26.0) which use atoms for locale names and rbnf locale names. This is consistent with other elements of `t:Cldr.LanguageTag` where atoms are used when the cardinality of the data is fixed and relatively small and strings where the data is free format.

## Cldr Territories v2.3.0 October 27th, 2021

### Enhancements

* Updates to support [CLDR release 40](https://cldr.unicode.org/index/downloads/cldr-40) via [ex_cldr version 2.24](https://hex.pm/packages/ex_cldr/2.24.0)

* Replace deprecated `Cldr.Config.get_locale/2` and `Cldr.Config.known_locale_names/1` with the replacement versions in `Cldr.Locale.Loader`

### Deprecations

* Updates minimum Elixir version to 1.10 since this is the minimum supported by `ex_cldr` version 2.24 and later.

## Cldr Territories v2.3.0-rc.0 October 19th, 2021

### Enhancements

* Updates to `ex_cldr` version `2.24` which uses [CLDR 40](https://cldr.unicode.org/index/downloads/cldr-40) data

* Both territories and territory subdivisions are now represented as atoms in the canonical form rather than the previous binary representation.

## Cldr Territories v2.2.2 May 11th, 2021

### Enhancements

* Fix bug in `translate_territory!/4` [#16](https://github.com/Schultzer/cldr_territories/pull/16), thanks to @leandrocp.

* Fix bug in `translate_subdivision!/4`.

## Cldr Territories v2.2.1 May 10th, 2021

### Enhancements

* Fix specs for `known_territories/1`, `known_subdivisions/1`, `from_subdivision_code/2,3` and `from_subdivision_code!/2,3` [#14](https://github.com/Schultzer/cldr_territories/issues/14)

## Cldr Territories v2.2.0 April 19th, 2021

### Enhancements

* Requires `ex_cldr` version `2.20` or later to use CLDR data version 39. As with all CLDR releases, underlying data can change and tests are updated to reflect those changes.

* Added `known_subdivisions/1`, `known_territory_subdivisions/2`, `from_subdivision_code/3` and `translate_subdivision/4` to support subdivison, thansk to @mskv.

* Improved proformance for `from_territory_code/2`, `from_subdivision_code/2`, `translate_territory/4` and `translate_subdivision/4`, thanks to @kipcole9.

## Cldr Territories v2.1.0 June 8th, 2020

### Enhancements

* Requires `ex_cldr` version `2.14` or later to use CLDR data version 37. As with all CLDR releases, underlying data can change and tests are updated to reflect those changes.

* Updated readme to reflect changes in EU composition and the updated data returned territories

* CLDR 37 also reflects that the UK is no longer part of the EU.

* Minimum version of Elixir required is 1.8 to align with the baseline `ex_cldr` library

* Fix typespec leading to dialyzer errors

* Update dependencies in development

## Cldr Territories v2.0.1 May 1st, 2019

### Enhancements

* Fix dialyzer errors thanks to @jeroenvisser101

## Cldr Territories v2.0.0 November 25st, 2018

This is the changelog for Cldr Territories v2.0.0 released on November 25th, 2018. For older changelogs please consult the release tag on [GitHub](https://github.com/schultzer/cldr_territories/tags)

### Enhancements

* Move to a backend module structure with [ex_cldr](https://hex.pm/packages/ex_cldr) version 2.0