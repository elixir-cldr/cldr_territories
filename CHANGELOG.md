# Changelog

## Cldr Territories v1.4.0 October 21st, 2018

### Enhancements

* Updates [ex_cldr](https://hex,pm/packages/ex_cldr) to version 1.8.0 which uses CLDR data release 34.0.0

## Cldr Territories v1.3.1 May 10, 2018

### Bug fix

* Fixed a bug introduced in 1.3.0 where a function with `!` and `as_option` resulted in `{:ok, result}` instead of `result`

## Cldr Territories v1.3.0 May 8, 2018

### Enhancements

* Added options `[as: :atom]`, `[as: :binary]` and `[as: :charlist]` to following functions the defualt is `[as: :atom]`
  * `parent/2` and `parent!/2`
  * `children/2` and `children!/2`
  * `to_currency_code/2` and `to_currency_code!/2`
  * `to_currency_codes/2` and `to_currency_codes!/2`
  * `country_codes/1`
* Improved specs
* Relaxed posion and jason dependency

## Cldr Territories v1.2.0 Marts 28, 2018

### Enhancements

* Update `ex_cldr` dependency to version 1.5 which uses CLDR data version 33

## Cldr Territories v1.1.2 January 11, 2018

### Enhancements

* Relax `ex_cldr` requirement

## Cldr Territories v1.1.1 December 13, 2017

### Bug fix

* Load data on compile

## Cldr Territories v1.1.0 December 8, 2017

Following helper method has been added

### Enhancements

* `to_currency_code/1` and `to_currency_code!/1`
* `to_currency_codes/1` and `to_currency_codes!/1`
* `country_codes/0`


## Cldr Territories v1.0.0 December 8, 2017

### Enhancements

* Release

## Cldr Territories v1.0.0-rc.0 November 17, 2017

### Enhancements

* Release candidate
