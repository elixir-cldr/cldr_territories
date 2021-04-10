# Changelog

## Cldr Territories v2.2.0 TBD

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