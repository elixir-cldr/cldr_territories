# Changelog

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