defmodule Cldr.Territory do
  @moduledoc """
  Supports the CLDR Territories definitions which provide for the localization of many
  territories.

  The public API defines three primary functions:

  * `Cldr.Territory.from_territory_code/2` which, given a territory code will output a localized string

  * `Cldr.Territory.translate/3` which, translate one localized string and locale to a another

  * `Cldr.Territory.available_territories/0` identifies the available territories for localization

  """

  require Cldr
  alias Cldr.Locale

  @doc """
  Returns the available territories for a given locale.
  * `locale` is any configured locale. See `Cldr.known_locales()`. The default
    is `locale: Cldr.get_current_locale()`

  ## Example
      Cldr.Territory.available_territories
      [:gb, :pt]
  """
  @spec available_territories(term) :: list(atom)
  def available_territories(locale \\ Cldr.get_current_locale())

  @doc """
  Returns a localized string for the given territory code.

  Defaults to current locale.

  ## Example
      iex> Cldr.Territory.from_territory(:gb)
      "UK"

      iex> Cldr.Territory.from_territory(:gb, :pt)
      "Reino Unido"
  """
  @spec from_territory(String.t | atom, atom) :: String.t
  def from_territory(territory_code, locale \\ Cldr.get_current_locale())

  @doc """
  Translate a localized string from one locale to another.

  Defaults to current locale.

  ## Example
      iex> Cldr.Territory.translate("Reino Unido", :pt)
      "UK"

      iex> Cldr.Territory.translate("U.K.", :en, :pt)
      "Reino Unido"
  """
  @spec translate(String.t, atom, atom) :: String.t
  def translate(localized_string, from_locale, to_locale \\ Cldr.get_current_locale())

  # Generate the functions that encapsulate the territory data from CDLR
  for locale_name <- Cldr.Config.known_locales() do
    territories = locale_name |> Cldr.Config.get_locale() |> Map.get(:territories)


    def available_territories(unquote(locale_name)) do
      unquote(Map.keys(territories) |> Enum.sort)
    end

    def from_territory(territory, unquote(locale_name)) do
      Map.get(unquote(Macro.escape(territories)), territory)
    end

    def translate(localized_string, locale_from, unquote(locale_name)) do
      {territory, _string} = locale_from |> Cldr.Config.get_locale() |> Map.get(:territories) |> Enum.find(fn {k, v} -> v == localized_string end)

      Map.get(unquote(Macro.escape(territories)), territory)
    end
  end
end
