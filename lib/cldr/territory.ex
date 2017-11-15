defmodule Cldr.Territory do
  @moduledoc """
  Supports the CLDR Territories definitions which provide the localization of many
  territories.
  """

  require Cldr
  alias Cldr.LanguageTag
  alias Cldr.Locale

  @territory_style [:short, :standard, :variant]
  @default_style :standard
  @default_locale Cldr.get_current_locale()
  @default_options [locale: @default_locale, style: @default_style]

  @doc """
  Returns a list of available styles.

  ## Example

      => Cldr.Territory.available_styles
      [:short, :standard, :variant]
  """
  @spec available_styles() :: list(atom)
  def available_styles(), do: @territory_style

  @doc """
  Returns the available territories for a given locale.

  * `locale` is any configured locale. See `Cldr.known_locales()`. The default
    is `locale: Cldr.get_current_locale()`

  ## Example

      => Cldr.Territory.available_territories
      [:GS, :AL, :"155", :AM, :IL, :CH, :CG, :EG, :SO, :MT, :AS, :GL, :MU, :AR, :TV,
       :AI, :KR, :SA, :BI, :"054", :MY, :MW, :MS, :PM, :VC, :"143", :EC, :LK, :DG,
       :KH, :BR, :CR, :HN, :"HK-alt-short", :NU, :LV, :FR, :CC, :CI, :KI, :KZ, :TM,
       :KP, :MO, :TA, :BE, :BA, :ML, :XK, :US, ...]

      => Cldr.Territory.available_territories("zzz")
      {:error, {Cldr.UnknownLocaleError, "The locale \"zzz\" is not known."}}

  """
  @spec available_territories(String.t | LanguageTag.t) :: list(atom) | {:error, {Exeption.t, String.t}}
  def available_territories(locale \\ Cldr.get_current_locale())
  def available_territories(%LanguageTag{cldr_locale_name: cldr_locale_name}) do
    available_territories(cldr_locale_name)
  end

  @doc """
  Returns a map of all knwon territories in a given locale.

  * `locale` is any configured locale. See `Cldr.known_locales()`. The default
    is `locale: Cldr.get_currenct_locale()`

  ## Example

      => Cldr.Territory.known_territories
      %{SN: %{standard: "Senegal"}, "061": %{standard: "Polynesia"},
      BH: %{standard: "Bahrain"}, TM: %{standard: "Turkmenistan"},
      "009": %{standard: "Oceania"}, CW: %{standard: "Curaçao"},
      FR: %{standard: "France"}, TN: %{standard: "Tunisia"},
      FI: %{standard: "Finland"}, BF: %{standard: "Burkina Faso"},
      "155": %{standard: "Western Europe"}, GL: %{standard: "Greenland"},
      VI: %{standard: "U.S. Virgin Islands"}, ZW: %{standard: "Zimbabwe"},
      AR: %{standard: "Argentina"}, SG: %{standard: "Singapore"},
      SZ: %{standard: "Swaziland"}, ID: %{standard: "Indonesia"},
      NR: %{standard: "Nauru"}, RW: %{standard: "Rwanda"},
      TR: %{standard: "Turkey"}, IS: %{standard: "Iceland"},
      ME: %{standard: "Montenegro"}, AW: %{standard: "Aruba"},
      PY: %{standard: "Paraguay"}, "145": %{standard: "Western Asia"},
      CG: %{standard: "Congo - Brazzaville", variant: "Congo (Republic)"},
      LT: %{standard: "Lithuania"}, SA: %{standard: "Saudi Arabia"},
      MZ: %{standard: "Mozambique"}, NU: %{standard: "Niue"},
      NG: %{standard: "Nigeria"}, CK: %{standard: "Cook Islands"},
      ZM: %{standard: "Zambia"}, LK: %{standard: "Sri Lanka"},
      UY: %{standard: "Uruguay"}, YE: %{standard: "Yemen"},
      "011": %{standard: "Western Africa"},
      CC: %{standard: "Cocos (Keeling) Islands"}, BY: %{standard: "Belarus"},
      IL: %{standard: "Israel"}, KY: %{standard: "Cayman Islands"},
      GN: %{standard: "Guinea"}, VN: %{standard: "Vietnam"},
      PE: %{standard: "Peru"}, HU: %{standard: "Hungary"},
      HN: %{standard: "Honduras"}, GI: %{standard: "Gibraltar"},
      "142": %{standard: "Asia"}, "029": %{...}, ...}

      => Cldr.Territory.known_territories("zzz")
      {:error, {Cldr.UnknownLocaleError, "The locale \"zzz\" is not known."}}
  """
  @spec known_territories(String.t | LanguageTag.t) :: map | {:error, {Exeption.t, String.t}}
  def known_territories(locale \\ Cldr.get_current_locale())
  def known_territories(%LanguageTag{cldr_locale_name: cldr_locale_name}) do
    known_territories(cldr_locale_name)
  end


  @doc """
  Localized string for the given territory code.
  Returns `{:ok, String.t}` if successful, otherwise `{:error, reason}`.

  * `options` are:
    * `locale` is any configured locale. See `Cldr.known_locales()`. The default
      is `locale: Cldr.get_currenct_locale()`

    * `style` is one of those returned by `Cldr.Territory.available_styles`.
      The current styles are `:short`, `:standard` and `:variant`.  The default is `style: :standard`

  ## Example

      iex> Cldr.Territory.from_territory_code(:GB)
      {:ok, "United Kingdom"}

      iex> Cldr.Territory.from_territory_code(:GB, [style: :short])
      {:ok, "UK"}

      iex> Cldr.Territory.from_territory_code(:GB, [style: :ZZZ])
      {:error, {Cldr.UnknownStyleError, "The style :ZZZ is unknown"}}

      iex> Cldr.Territory.from_territory_code(:GB, [style: "ZZZ"])
      {:error, {Cldr.UnknownStyleError, "The style \\"ZZZ\\" is unknown"}}

      iex> Cldr.Territory.from_territory_code(:GB, [locale: "pt"])
      {:ok, "Reino Unido"}

      #iex> Cldr.Territory.from_territory_code(:GB, [locale: :zzz])
      {:error, {Cldr.UnknownLocaleError, "The locale :zzz is not known."}}

      #iex> Cldr.Territory.from_territory_code(:GB, [locale: "zzz"])
      {:error, {Cldr.UnknownLocaleError, "The locale \"zzz\" is not known."}}
  """
  @spec from_territory_code(atom, String.t | LanguageTag.t) :: {:ok, String.t} | {:error, {Exeption.t, String.t}}
  def from_territory_code(territory_code, options \\ @default_options)
  def from_territory_code(territory_code, [locale: %LanguageTag{cldr_locale_name: cldr_locale_name}]) do
    from_territory_code(territory_code, [locale: cldr_locale_name, style: @default_style])
  end
  def from_territory_code(territory_code, [locale: %LanguageTag{cldr_locale_name: cldr_locale_name}, style: style]) do
    from_territory_code(territory_code, [locale: cldr_locale_name, style: style])
  end
  def from_territory_code(territory_code, [locale: locale]) do
    from_territory_code(territory_code, [locale: locale, style: @default_style])
  end
  def from_territory_code(territory_code, [style: style]) do
    from_territory_code(territory_code, [locale: @default_locale, style: style])
  end
  def from_territory_code(territory_code, [locale: locale, style: style]) do
    territory_code
    |> validate_territory()
    |> validate_locale(locale)
    |> case do
        {:error, reason}   -> {:error, reason}
        {:ok, locale_name} -> from_territory_code(territory_code, locale_name, style)
       end
  end

  @doc """
  Localized string for the given territory code.
  The same as `from_territory_code/2`, but raises an exception if it fails.

  * `options` are:
    * `locale` is any configured locale. See `Cldr.known_locales()`. The default
      is `locale: Cldr.get_currenct_locale()`

    * `style` is one of those returned by `Cldr.Territory.available_styles`.
      The current styles are `:short`, `:standard` and `:variant`.  The default is `style: :standard`

  ## Example

      iex> Cldr.Territory.from_territory_code!(:GB)
      "United Kingdom"

      iex> Cldr.Territory.from_territory_code!(:GB, [style: :short])
      "UK"

      iex> Cldr.Territory.from_territory_code!(:GB, [locale: "pt"])
      "Reino Unido"
  """
  @spec from_territory_code!(atom, String.t | LanguageTag.t) :: String.t | Exeption.t
  def from_territory_code!(territory_code, opts \\ @default_options)
  def from_territory_code!(territory_code, [locale: %LanguageTag{cldr_locale_name: cldr_locale_name}]) do
    from_territory_code!(territory_code, [locale: cldr_locale_name, style: @default_style])
  end
  def from_territory_code!(territory_code, [locale: %LanguageTag{cldr_locale_name: cldr_locale_name}, style: style]) do
    from_territory_code!(territory_code, [locale: cldr_locale_name, style: style])
  end
  def from_territory_code!(territory_code, [locale: locale]) do
    from_territory_code!(territory_code, [locale: locale, style: @default_style])
  end
  def from_territory_code!(territory_code, [style: style]) do
    from_territory_code!(territory_code, [locale: @default_locale, style: style])
  end
  def from_territory_code!(territory_code, options) do
    case from_territory_code(territory_code, options) do
      {:ok, result}    -> result
      {:error, {exception, msg}} -> raise exception, msg
    end
  end

  @doc """
  Translate a localized string from one locale to another.
  Returns `{:ok, String.t}` if successful, otherwise `{:error, reason}`.

  * `locale` is any configured locale. See `Cldr.known_locales()`. The default
    is `locale: Cldr.get_current_locale()`

  ## Example

      iex> Cldr.Territory.translate_territory("Reino Unido", "pt")
      {:ok, "UK"}

      iex> Cldr.Territory.translate_territory("United Kingdom", "en", "pt")
      {:ok, "Reino Unido"}

      iex> Cldr.Territory.translate_territory("Reino Unido", :zzz)
      {:error, {Cldr.UnknownLocaleError, "The locale :zzz is not known."}}

      iex> Cldr.Territory.translate_territory("United Kingdom", "en", "zzz")
      {:error, {Cldr.UnknownLocaleError, "The locale \\"zzz\\" is not known."}}
  """
  @spec translate_territory(String.t, String.t, String.t | LanguageTag.t) :: {:ok, String.t} | {:error, {Exeption.t, String.t}}
  def translate_territory(localized_string, from_locale, to_locale \\ Cldr.get_current_locale())
  def translate_territory(localized_string, from_locale, %LanguageTag{cldr_locale_name: cldr_locale_name}) do
    translate_territory(localized_string, from_locale, cldr_locale_name)
  end

  @doc """
  The same as `translate_territory/3`, but raises an exception if it fails.

  * `locale` is any configured locale. See `Cldr.known_locales()`. The default
    is `locale: Cldr.get_current_locale()`

  ## Example

      iex> Cldr.Territory.translate_territory!("Reino Unido", "pt")
      "UK"

      iex> Cldr.Territory.translate_territory!("United Kingdom", "en", "pt")
      "Reino Unido"
  """
  @spec translate_territory(String.t, String.t, String.t | LanguageTag.t) :: String.t | Exeption.t
  def translate_territory!(localized_string, from_locale, to_locale \\ Cldr.get_current_locale())
  def translate_territory!(localized_string, from_locale, %LanguageTag{cldr_locale_name: cldr_locale_name}) do
    translate_territory!(localized_string, from_locale, cldr_locale_name)
  end
  def translate_territory!(localized_string, locale_from, locale_name) do
    case translate_territory(localized_string, locale_from, locale_name) do
      {:ok, result}    -> result
      {:error, {exception, msg}} -> raise exception, msg
    end
  end

  @children List.flatten(for {_k, v} <- Cldr.Config.territory_containment(), do: v)
  @doc """
  Lists parent(s) for the given territory code.
  Returns `{:ok, list}` if successful, otherwise `{:error, reason}`.

  * `locale` is any configured locale. See `Cldr.known_locales()`. The default
    is `locale: Cldr.get_current_locale()`

  ## Example

      iex> Cldr.Territory.parent(:GB)
      {:ok, [:"154", :EU, :UN]}

      iex> Cldr.Territory.parent(:ZZZ)
      {:error, {Cldr.UnknownTerritoryError, "The territory :ZZZ is unknown"}}

      iex> Cldr.Territory.parent(:"001")
      {:error, {Cldr.UnknownChildrenError, "The territory :\\"001\\" has no parent(s)"}}
  """
  @spec parent(atom) :: {:ok, list(atom)} | {:error, {Exeption.t, String.t}}
  for code <- [:UN, :EU, :EZ] do
    def parent(unquote(code)), do: {:ok, [:"001"]}
  end
  def parent(territory_code) do
    territory_code
    |> validate_territory()
    |> case do
         {:error, error} -> {:error, error}
         {:ok, code}     -> @children
                            |> Enum.member?(code)
                            |> case do
                                 false -> {:error, {Cldr.UnknownChildrenError, "The territory #{inspect code} has no parent(s)"}}

                                 true  -> {:ok, Cldr.Config.territory_containment()
                                                |> Enum.filter(fn({_parent, children}) -> Enum.member?(children, code) end)
                                                |> Enum.map(fn({parent, _children}) -> parent end)
                                                |> Enum.sort}
                               end
       end
  end

  @doc """
  The same as `parent/1`, but raises an exception if it fails.

  * `locale` is any configured locale. See `Cldr.known_locales()`. The default
    is `locale: Cldr.get_current_locale()`

  ## Example

      iex> Cldr.Territory.parent!(:GB)
      [:"154", :EU, :UN]

  """
  @spec parent!(atom) :: list(atom) | term()
  def parent!(territory_code) do
    case parent(territory_code) do
      {:ok, result}              -> result
      {:error, {exception, msg}} -> raise exception, msg
    end
  end


  @parents (for {k, _v} <- Cldr.Config.territory_containment(), do: k)
  @doc """
  Lists children(s) for the given territory code.
  Returns `{:ok, list}` if successful, otherwise `{:error, reason}`.

  * `locale` is any configured locale. See `Cldr.known_locales()`. The default
    is `locale: Cldr.get_current_locale()`

  ## Example

      iex> Cldr.Territory.children(:EU)
      {:ok,
       [:AT, :BE, :CY, :CZ, :DE, :DK, :EE, :ES, :FI, :FR, :GB, :GR, :HR, :HU, :IE,
        :IT, :LT, :LU, :LV, :MT, :NL, :PL, :PT, :SE, :SI, :SK, :BG, :RO]}

      iex> Cldr.Territory.children(:ZZZ)
      {:error, {Cldr.UnknownTerritoryError, "The territory :ZZZ is unknown"}}

      iex> Cldr.Territory.children(:GB)
      {:error, {Cldr.UnknownParentError, "The territory :GB has no children"}}
  """
  @spec children(atom) :: {:ok, list(atom)} | {:error, {Exeption.t, String.t}}
  def children(territory_code) do
    territory_code
    |> validate_territory()
    |> case do
         {:error, error} -> {:error, error}
         {:ok, code}     -> @parents
                            |> Enum.member?(code)
                            |> case do
                                 true  -> {:ok, Cldr.Config.territory_containment()[code]}
                                 false -> {:error, {Cldr.UnknownParentError, "The territory #{inspect code} has no children"}}
                               end
       end
  end

  @doc """
  The same as `children/1`, but raises an exception if it fails.

  * `locale` is any configured locale. See `Cldr.known_locales()`. The default
    is `locale: Cldr.get_current_locale()`

  ## Example

      iex> Cldr.Territory.children!(:EU)
      [:AT, :BE, :CY, :CZ, :DE, :DK, :EE, :ES, :FI, :FR, :GB, :GR, :HR, :HU, :IE, :IT,
       :LT, :LU, :LV, :MT, :NL, :PL, :PT, :SE, :SI, :SK, :BG, :RO]
  """
  @spec children!(atom) :: list(atom) | term()
  def children!(territory_code) do
    case children(territory_code) do
      {:ok, result}              -> result
      {:error, {exception, msg}} -> raise exception, msg
    end
  end

  @doc """
  Checks relationship between two territories, where the first argument is the `parent` and second the `child`.
  Returns `true` if successful, otherwise `false`.

  * `locale` is any configured locale. See `Cldr.known_locales()`. The default
    is `locale: Cldr.get_current_locale()`

  ## Example

      iex> Cldr.Territory.contains?(:EU, :DK)
      true

      iex> Cldr.Territory.contains?(:DK, :EU)
      false
  """
  @spec contains?(atom, atom) :: true | false
  def contains?(parent, child) do
    @parents
    |> Enum.member?(parent)
    |> case do
         true  -> Enum.member?(Cldr.Config.territory_containment()[parent], child)
         false -> false
       end
  end

  @doc """
  Maps territory info for the given territory code.
  Returns `{:ok, map}` if successful, otherwise `{:error, reason}`.

  ## Example

      iex> Cldr.Territory.info(:GB)
      {:ok, %{currency: %{GBP: %{from: ~D[1694-07-27]}}, gdp: 2788000000000,
             language_population: %{"bn" => %{population_percent: 0.67},
               "cy" => %{official_status: "official_regional",
                 population_percent: 0.77}, "de" => %{population_percent: 6},
               "el" => %{population_percent: 0.34},
               "en" => %{official_status: "official", population_percent: 99},
               "fr" => %{population_percent: 19},
               "ga" => %{official_status: "official_regional",
                 population_percent: 0.026},
               "gd" => %{official_status: "official_regional",
                 population_percent: 0.099, writing_percent: 5},
               "it" => %{population_percent: 0.34},
               "ks" => %{population_percent: 0.19},
               "kw" => %{population_percent: 0.0031},
               "ml" => %{population_percent: 0.035},
               "pa" => %{population_percent: 0.79},
               "sco" => %{population_percent: 2.7, writing_percent: 5},
               "syl" => %{population_percent: 0.51},
               "yi" => %{population_percent: 0.049},
               "zh-Hant" => %{population_percent: 0.54}}, literacy_percent: 99,
             measurement_system: "UK", paper_size: "A4", population: 64769500,
             telephone_country_code: 44, temperature_measurement: "metric"}}
  """
  @spec info(atom) :: {:ok, map} | {:error, term()}
  def info(territory_code) do
    territory_code
    |> validate_territory
    |> case do
         {:error, reason} -> {:error, reason}
         {:ok, code}      -> {:ok, Cldr.Config.territory_info()[code]}
       end
  end

  @doc """
  The same as `info/1`, but raises an exception if it fails.

  ## Example

      iex> Cldr.Territory.info!(:GB)
      %{currency: %{GBP: %{from: ~D[1694-07-27]}}, gdp: 2788000000000,
                   language_population: %{"bn" => %{population_percent: 0.67},
                     "cy" => %{official_status: "official_regional",
                       population_percent: 0.77}, "de" => %{population_percent: 6},
                     "el" => %{population_percent: 0.34},
                     "en" => %{official_status: "official", population_percent: 99},
                     "fr" => %{population_percent: 19},
                     "ga" => %{official_status: "official_regional",
                       population_percent: 0.026},
                     "gd" => %{official_status: "official_regional",
                       population_percent: 0.099, writing_percent: 5},
                     "it" => %{population_percent: 0.34},
                     "ks" => %{population_percent: 0.19},
                     "kw" => %{population_percent: 0.0031},
                     "ml" => %{population_percent: 0.035},
                     "pa" => %{population_percent: 0.79},
                     "sco" => %{population_percent: 2.7, writing_percent: 5},
                     "syl" => %{population_percent: 0.51},
                     "yi" => %{population_percent: 0.049},
                     "zh-Hant" => %{population_percent: 0.54}}, literacy_percent: 99,
                   measurement_system: "UK", paper_size: "A4", population: 64769500,
                   telephone_country_code: 44, temperature_measurement: "metric"}
  """
  @spec info!(atom) :: map | term()
  def info!(territory_code) do
    case info(territory_code) do
      {:ok, result}              -> result
      {:error, {exception, msg}} -> raise exception, msg
    end
  end

  # Generate the functions that encapsulate the territory data from CDLR
  for locale_name <- Cldr.Config.known_locale_names() do
    territories = locale_name |> Cldr.Config.get_locale() |> Map.get(:territories)

    def available_territories(unquote(locale_name)) do
      unquote(Map.keys territories)
    end

    def known_territories(unquote(locale_name)) do
      unquote(Macro.escape(territories))
    end

    def from_territory_code(territory_code, unquote(locale_name), style) do
      unquote(Macro.escape(territories))
      |> get_in([territory_code, style])
      |> case do
        nil    -> {:error, {Cldr.UnknownStyleError, "The style #{inspect style} is unknown"}}
        string -> {:ok, string}
      end
    end

    def translate_territory(localized_string, locale_from, unquote(locale_name)) do
      locale_from
      |> Cldr.validate_locale()
      |> case do
         {:error, reason} -> {:error, reason}

         {:ok, %LanguageTag{cldr_locale_name: locale}} ->
           {code, style} = locale
                           |> Cldr.Config.get_locale()
                           |> Map.get(:territories)
                           |> Enum.map(fn {code, map} -> for {style, string} when string == localized_string <- map, do: {code, style} end)
                           |> List.flatten
                           |> Kernel.hd


           {:ok, (unquote(Macro.escape(territories))[code][style])}
        end
    end
  end

  def available_territories(locale), do: {:error, Locale.locale_error(locale)}

  def known_territories(locale), do: {:error, Locale.locale_error(locale)}

  def translate_territory(_localized_string, _from, locale), do: {:error, Locale.locale_error(locale)}

  @spec validate_territory(atom | String.t) :: {:error, {Exeption.t, String.t}} | {:ok, atom}
  defp validate_territory(territory_code) do
    territory_code
    |> Cldr.validate_territory()
    |> case do
         {:error, reason} -> {:error, reason}
         {:ok, code}     -> {:ok, code}
       end
  end
  @spec validate_locale({:error, {Exeption.t, String.t}} | {:ok, atom}, String.t) :: {:error, {Exeption.t, String.t}} | {:ok, String.t}
  defp validate_locale({:error, reason}, _locale), do: {:error, reason}
  defp validate_locale({:ok, _code}, locale) do
    case Cldr.validate_locale(locale) do
      {:error, error} -> {:error, error}
      {:ok, %LanguageTag{cldr_locale_name: locale_name}} -> {:ok, locale_name}
    end
  end

end
