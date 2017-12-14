defmodule Cldr.Territory do
  @moduledoc """
  Supports the CLDR Territories definitions which provide the localization of many
  territories.
  """

  require Cldr
  alias Cldr.LanguageTag
  alias Cldr.Locale

  @styles [:short, :standard, :variant]
  @default_style [style: :standard]
  @default_locale [locale: Cldr.get_current_locale()]
  @territory_containment Cldr.Config.territory_containment()
  @territory_info Cldr.Config.territory_info()

  @doc """
  Returns a list of available styles.

  ## Example

      => Cldr.Territory.available_styles
      [:short, :standard, :variant]
  """
  @spec available_styles() :: list(atom)
  def available_styles(), do: @styles

  @doc """
  Returns the available territories for a given locale.

  * `locale` is any configured locale. See `Cldr.known_locale_names/0`.
    The default is `Cldr.get_current_locale/0`

  ## Example

      => Cldr.Territory.available_territories
      [:"001", :"002", :"003", :"005", :"009", :"011", :"013", :"014", :"015", :"017",
       :"018", :"019", :"021", :"029", :"030", :"034", :"035", :"039", :"053", :"054",
       :"057", :"061", :"142", :"143", :"145", :"150", :"151", :"154", :"155", :"202",
       :"419", :AC, :AD, :AE, :AF, :AG, :AI, :AL, :AM, :AO, :AQ, :AR, :AS, :AT, :AU,
       :AW, :AX, :AZ, :BA, :BB, ...]

      => Cldr.Territory.available_territories("zzz")
      {:error, {Cldr.UnknownLocaleError, "The locale \"zzz\" is not known."}}
  """
  @spec available_territories(String.t | LanguageTag.t) :: list(atom) | {:error, {Exeption.t, String.t}}
  def available_territories(locale \\ Cldr.get_current_locale())
  def available_territories(%LanguageTag{cldr_locale_name: cldr_locale_name}) do
    available_territories(cldr_locale_name)
  end

  @doc """
  Returns a map of all known territories in a given locale.

  * `locale` is any configured locale. See `Cldr.known_locale_names/0`.
    The default is `Cldr.get_currenct_locale/0`

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
    * `locale` is any configured locale. See `Cldr.known_locale_names/0`.
      The default is `Cldr.get_current_locale/0`

    * `style` is one of those returned by `Cldr.Territory.available_styles/0`.
      The current styles are `:short`, `:standard` and `:variant`.
      The default is `:standard`

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

      iex> Cldr.Territory.from_territory_code(:GB, [locale: :zzz])
      {:error, {Cldr.UnknownLocaleError, "The locale :zzz is not known."}}

      iex> Cldr.Territory.from_territory_code(:GB, [locale: "zzz"])
      {:error, {Cldr.UnknownLocaleError, "The locale \\"zzz\\" is not known."}}
  """
  @spec from_territory_code(atom | String.t | LanguageTag.t, Keyword.t) :: {:ok, String.t} | {:error, {Exeption.t, String.t}}
  def from_territory_code(territory_code, options \\ [locale: Cldr.get_current_locale(), style: :standard])
  def from_territory_code(territory_code, [locale: %LanguageTag{cldr_locale_name: cldr_locale_name}]) do
    from_territory_code(territory_code, [locale: cldr_locale_name] ++ @default_style)
  end
  def from_territory_code(territory_code, [locale: %LanguageTag{cldr_locale_name: cldr_locale_name}, style: style]) do
    from_territory_code(territory_code, [locale: cldr_locale_name, style: style])
  end
  def from_territory_code(territory_code, [locale: locale]) do
    from_territory_code(territory_code, [locale: locale] ++ @default_style)
  end
  def from_territory_code(territory_code, [style: style]) do
    from_territory_code(territory_code, @default_locale ++ [style: style])
  end
  def from_territory_code(territory_code, [locale: locale, style: style]) do
    territory_code
    |> Cldr.validate_territory()
    |> validate_locale(locale)
    |> case do
        {:error, reason}         -> {:error, reason}

        {:ok, code, locale_name} -> from_territory_code(code, locale_name, style)
       end
  end

  @doc """
  The same as `from_territory_code/2`, but raises an exception if it fails.

  ## Example

      iex> Cldr.Territory.from_territory_code!(:GB)
      "United Kingdom"

      iex> Cldr.Territory.from_territory_code!(:GB, [style: :short])
      "UK"

      iex> Cldr.Territory.from_territory_code!(:GB, [locale: "pt"])
      "Reino Unido"
  """
  @spec from_territory_code!(atom | String.t | LanguageTag.t, Keyword.t) :: String.t | Exeption.t
  def from_territory_code!(territory_code, options \\ [locale: Cldr.get_current_locale(), style: :standard])
  def from_territory_code!(territory_code, [locale: %LanguageTag{cldr_locale_name: cldr_locale_name}]) do
    from_territory_code!(territory_code, [locale: cldr_locale_name] ++ @default_style)
  end
  def from_territory_code!(territory_code, [locale: %LanguageTag{cldr_locale_name: cldr_locale_name}, style: style]) do
    from_territory_code!(territory_code, [locale: cldr_locale_name, style: style])
  end
  def from_territory_code!(territory_code, [locale: locale]) do
    from_territory_code!(territory_code, [locale: locale] ++ @default_style)
  end
  def from_territory_code!(territory_code, [style: style]) do
    from_territory_code!(territory_code, @default_locale ++ [style: style])
  end
  def from_territory_code!(territory_code, options) do
    case from_territory_code(territory_code, options) do
      {:ok, result}              -> result

      {:error, {exception, msg}} -> raise exception, msg
    end
  end

  @doc """
  Localized string for the given `LanguageTag.t`.
  Returns `{:ok, String.t}` if successful, otherwise `{:error, reason}`.

  * `options` are:
    * `style` is one of those returned by `Cldr.Territory.available_styles/0`.
      The current styles are `:short`, `:standard` and `:variant`.
      The default is `:standard`

  ## Example

      iex> Cldr.Territory.from_language_tag(Cldr.get_current_locale())
      {:ok, "World"}

      iex> Cldr.Territory.from_language_tag(Cldr.get_current_locale(), [style: :short])
      {:error, {Cldr.UnknownStyleError, "The style :short is unknown"}}

      iex> Cldr.Territory.from_language_tag(Cldr.get_current_locale(), [style: :ZZZ])
      {:error, {Cldr.UnknownStyleError, "The style :ZZZ is unknown"}}

      iex> Cldr.Territory.from_language_tag(Cldr.get_current_locale(), [style: "ZZZ"])
      {:error, {Cldr.UnknownStyleError, "The style \\"ZZZ\\" is unknown"}}
  """
  @spec from_language_tag(LanguageTag.t) :: {:ok, String.t} | {:error, {Exception.t, String.t}}
  def from_language_tag(tag, options \\ @default_style)
  def from_language_tag(%LanguageTag{cldr_locale_name: cldr_locale_name, territory: territory}, [style: style]) do
    from_territory_code(territory, [locale: cldr_locale_name] ++ [style: style])
  end
  def from_language_tag(tag, _options), do: {:error, {Cldr.UnknownLanguageTagError, "The tag #{inspect tag} is not a valid `LanguageTag.t`"}}

  @doc """
  The same as `from_language_tag/2`, but raises an exception if it fails.

  ## Example

      iex> Cldr.Territory.from_language_tag!(Cldr.get_current_locale())
      "World"
  """
  @spec from_language_tag!(LanguageTag.t) :: String.t | Exception.t
  def from_language_tag!(tag, options \\ @default_style)
  def from_language_tag!(%LanguageTag{cldr_locale_name: cldr_locale_name, territory: territory}, [style: style]) do
    from_territory_code!(territory, [locale: cldr_locale_name] ++ [style: style])
  end
  def from_language_tag!(tag, _options), do: raise Cldr.UnknownLanguageTagError, "The tag #{inspect tag} is not a valid `LanguageTag.t`"

  @doc """
  Translate a localized string from one locale to another.
  Returns `{:ok, result}` if successful, otherwise `{:error, reason}`.

  * `to_locale` is any configured locale. See `Cldr.known_locale_names/0`.
    The default is `Cldr.get_current_locale/0`

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
  @spec translate_territory(String.t, String.t | LanguageTag.t, String.t | LanguageTag.t) :: {:ok, String.t} | {:error, {Exeption.t, String.t}}
  def translate_territory(localized_string, from_locale, to_locale \\ Cldr.get_current_locale())
  def translate_territory(localized_string, %LanguageTag{cldr_locale_name: from_locale}, to_locale) do
    translate_territory(localized_string, from_locale, to_locale)
  end
  def translate_territory(localized_string, from_locale, %LanguageTag{cldr_locale_name: to_locale}) do
    translate_territory(localized_string, from_locale, to_locale)
  end

  @doc """
  The same as `translate_territory/3`, but raises an exception if it fails.

  ## Example

      iex> Cldr.Territory.translate_territory!("Reino Unido", "pt")
      "UK"

      iex> Cldr.Territory.translate_territory!("United Kingdom", "en", "pt")
      "Reino Unido"
  """
  @spec translate_territory!(String.t, String.t | LanguageTag.t, String.t | LanguageTag.t) :: String.t | Exeption.t
  def translate_territory!(localized_string, from_locale, to_locale \\ Cldr.get_current_locale())
  def translate_territory!(localized_string, %LanguageTag{cldr_locale_name: from_locale}, to_locale) do
    translate_territory(localized_string, from_locale, to_locale)
  end
  def translate_territory!(localized_string, from_locale, %LanguageTag{cldr_locale_name: to_locale}) do
    translate_territory!(localized_string, from_locale, to_locale)
  end
  def translate_territory!(localized_string, locale_from, locale_name) do
    case translate_territory(localized_string, locale_from, locale_name) do
      {:ok, result}              -> result

      {:error, {exception, msg}} -> raise exception, msg
    end
  end

  @doc """
  Translate a LanguageTag.t into a localized string from one locale to another.
  Returns `{:ok, result}` if successful, otherwise `{:error, reason}`.

  * `options` are:
    * `locale` is any configured locale. See `Cldr.known_locale_names/0`.
      The default is `Cldr.get_current_locale/0`

    * `style` is one of those returned by `Cldr.Territory.available_styles/0`.
      The current styles are `:short`, `:standard` and `:variant`.
      The default is `:standard`

  ## Example

      iex> Cldr.Territory.translate_language_tag(Cldr.get_current_locale())
      {:ok, "World"}

      iex> Cldr.Territory.translate_language_tag(Cldr.get_current_locale(), [locale: Cldr.Locale.new!("pt")])
      {:ok, "Mundo"}
  """
  @spec translate_language_tag(LanguageTag.t, [locale: LanguageTag.t | String.t, style: atom]) :: {:ok, String.t} | {:error, {Exeption.t, String.t}}
  def translate_language_tag(from_locale, options \\ [locale: Cldr.get_current_locale(), style: :standard])
  def translate_language_tag(%LanguageTag{} = from_locale, [locale: %LanguageTag{} = to_locale]) do
    translate_language_tag(from_locale, [locale: to_locale] ++ @default_style)
  end
  def translate_language_tag(%LanguageTag{} = from_locale, [style: style]) do
    translate_language_tag(from_locale, @default_locale ++ [style: style])
  end
  def translate_language_tag(%LanguageTag{} = from_locale,  [locale: %LanguageTag{} = to_locale, style: style]) do
    case from_language_tag(from_locale, [style: style]) do
      {:error, reason} -> {:error, reason}

      {:ok, result}    -> translate_territory(result, from_locale, to_locale)
    end
  end

  def translate_language_tag(%LanguageTag{}, [locale: tag, style: _style]) do
    {:error, {Cldr.UnknownLanguageTagError, "The tag #{inspect tag} is not a valid `LanguageTag.t`"}}
  end
  def translate_language_tag(%LanguageTag{}, [locale: tag]) do
    {:error, {Cldr.UnknownLanguageTagError, "The tag #{inspect tag} is not a valid `LanguageTag.t`"}}
  end
  def translate_language_tag(tag, _options) do
    {:error, {Cldr.UnknownLanguageTagError, "The tag #{inspect tag} is not a valid `LanguageTag.t`"}}
  end

  @doc """
  The same as `translate_language_tag/2`, but raises an exception if it fails.

  ## Example

      iex> Cldr.Territory.translate_language_tag!(Cldr.get_current_locale())
      "World"

      iex> Cldr.Territory.translate_language_tag!(Cldr.get_current_locale(), [locale: Cldr.Locale.new!("pt")])
      "Mundo"
  """
  @spec translate_language_tag!(LanguageTag.t, [locale: LanguageTag.t | String.t, style: atom]) :: String.t | Exeption.t
  def translate_language_tag!(locale_from, options \\ [locale: Cldr.get_current_locale(), style: :standard])
  def translate_language_tag!(locale_from, options) do
    case translate_language_tag(locale_from, options) do
      {:ok, result}              -> result

      {:error, {exception, msg}} -> raise exception, msg
    end
  end

  @children List.flatten(for {_k, v} <- @territory_containment, do: v)
  @doc """
  Lists parent(s) for the given territory code.
  Returns `{:ok, list}` if successful, otherwise `{:error, reason}`.

  ## Example

      iex> Cldr.Territory.parent(:GB)
      {:ok, [:"154", :EU, :UN]}

      iex> Cldr.Territory.parent(:ZZZ)
      {:error, {Cldr.UnknownTerritoryError, "The territory :ZZZ is unknown"}}

      iex> Cldr.Territory.parent(Cldr.get_current_locale())
      {:error, {Cldr.UnknownChildrenError, "The territory :\\"001\\" has no parent(s)"}}
  """
  @spec parent(LanguageTag.t | atom) :: {:ok, list(atom)} | {:error, {Exeption.t, String.t}}
  def parent(%LanguageTag{territory: territory_code}),  do: parent(territory_code)
  for code <- [:UN, :EU, :EZ] do
    def parent(unquote(code)), do: {:ok, [:"001"]}
  end
  def parent(territory_code) do
    territory_code
    |> Cldr.validate_territory()
    |> case do
         {:error, error} -> {:error, error}

         {:ok, code}     -> @children
                            |> Enum.member?(code)
                            |> case do
                                 false -> {:error, {Cldr.UnknownChildrenError, "The territory #{inspect code} has no parent(s)"}}

                                 true  -> {:ok, @territory_containment
                                                |> Enum.filter(fn({_parent, children}) -> Enum.member?(children, code) end)
                                                |> Enum.map(fn({parent, _children}) -> parent end)
                                                |> Enum.sort}
                               end
       end
  end

  @doc """
  The same as `parent/1`, but raises an exception if it fails.

  ## Example

      iex> Cldr.Territory.parent!(:GB)
      [:"154", :EU, :UN]

  """
  @spec parent!(LanguageTag.t | atom) :: list(atom) | Exception.t
  def parent!(%LanguageTag{territory: territory_code}),  do: parent!(territory_code)
  def parent!(territory_code) do
    case parent(territory_code) do
      {:ok, result}              -> result

      {:error, {exception, msg}} -> raise exception, msg
    end
  end

  @parents (for {k, _v} <- @territory_containment, do: k)
  @doc """
  Lists children(s) for the given territory code.
  Returns `{:ok, list}` if successful, otherwise `{:error, reason}`.

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
  @spec children(LanguageTag.t | atom) :: {:ok, list(atom)} | {:error, {Exeption.t, String.t}}
  def children(%LanguageTag{territory: territory_code}),  do: children(territory_code)
  def children(territory_code) do
    territory_code
    |> Cldr.validate_territory()
    |> case do
         {:error, error} -> {:error, error}

         {:ok, code}     -> @parents
                            |> Enum.member?(code)
                            |> case do
                                 true  -> {:ok, @territory_containment[code]}

                                 false -> {:error, {Cldr.UnknownParentError, "The territory #{inspect code} has no children"}}
                               end
       end
  end

  @doc """
  The same as `children/1`, but raises an exception if it fails.

  ## Example

      iex> Cldr.Territory.children!(:EU)
      [:AT, :BE, :CY, :CZ, :DE, :DK, :EE, :ES, :FI, :FR, :GB, :GR, :HR, :HU, :IE, :IT,
       :LT, :LU, :LV, :MT, :NL, :PL, :PT, :SE, :SI, :SK, :BG, :RO]
  """
  @spec children!(LanguageTag.t | atom) :: list(atom) | Exception.t
  def children!(%LanguageTag{territory: territory_code}),  do: children!(territory_code)
  def children!(territory_code) do
    case children(territory_code) do
      {:ok, result}              -> result

      {:error, {exception, msg}} -> raise exception, msg
    end
  end

  @doc """
  Checks relationship between two territories, where the first argument is the `parent` and second the `child`.
  Returns `true` if successful, otherwise `false`.

  ## Example

      iex> Cldr.Territory.contains?(:EU, :DK)
      true

      iex> Cldr.Territory.contains?(:DK, :EU)
      false
  """
  @spec contains?(LanguageTag.t | atom, LanguageTag.t | atom) :: true | false
  def contains?(%LanguageTag{territory: parent}, child), do: contains?(parent, child)
  def contains?(parent, %LanguageTag{territory: child}), do: contains?(parent, child)
  def contains?(parent, child) do
    @parents
    |> Enum.member?(parent)
    |> case do
         true  -> Enum.member?(@territory_containment[parent], child)

         false -> false
       end
  end

  @doc """
  Maps territory info for the given territory code.
  Returns `{:ok, map}` if successful, otherwise `{:error, reason}`.

  ## Example

      iex> Cldr.Territory.info(:GB)
      {:ok, %{currency: [GBP: %{from: ~D[1694-07-27]}], gdp: 2788000000000,
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
  @spec info(LanguageTag.t | atom) :: {:ok, map} | {:error, {Exception.t, String.t}}
  def info(%LanguageTag{territory: territory_code}), do: info(territory_code)
  def info(territory_code) do
    territory_code
    |> Cldr.validate_territory
    |> case do
         {:error, reason} -> {:error, reason}

         {:ok, code}      -> {:ok, @territory_info[code]}
       end
  end

  @doc """
  The same as `info/1`, but raises an exception if it fails.

  ## Example

      iex> Cldr.Territory.info!(:GB)
      %{currency: [GBP: %{from: ~D[1694-07-27]}], gdp: 2788000000000,
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
  @spec info!(LanguageTag.t | atom) :: map | Exception.t
  def info!(%LanguageTag{territory: territory_code}), do: info!(territory_code)
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
      unquote(Map.keys territories) |> Enum.sort
    end

    def known_territories(unquote(locale_name)) do
      unquote(Macro.escape(territories))
    end

    @doc false
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

  defp validate_locale({:error, reason}, _locale), do: {:error, reason}
  defp validate_locale({:ok, code}, locale) do
    locale
    |> Cldr.validate_locale()
    |> case do
         {:error, error}                                    -> {:error, error}

         {:ok, %LanguageTag{cldr_locale_name: locale_name}} -> {:ok, code, locale_name}
       end
  end

  @doc """
  Unicode flag for the given territory code.
  Returns `{:ok, flag}` if successful, otherwise `{:error, reason}`.

  ## Example

      iex> Cldr.Territory.to_unicode_flag(:US)
      {:ok, "🇺🇸"}

      iex> Cldr.Territory.to_unicode_flag(:EZ)
      {:error, {Cldr.UnknownFlagError, "The territory :EZ has no flag"}}
  """
  @spec to_unicode_flag(LanguageTag.t | atom | String.t | {:ok, atom} | {:error, {Exception.t, String.t}}) :: {:ok, String.t} | {:error, {Exception.t, String.t}}
  def to_unicode_flag(%LanguageTag{territory: territory_code}), do: to_unicode_flag(territory_code)
  def to_unicode_flag({:ok, territory_code}) do
    case flag_exists?(territory_code) do
      false -> {:error, {Cldr.UnknownFlagError, "The territory #{inspect territory_code} has no flag"}}

      true  -> {:ok, territory_code
                     |> Atom.to_charlist()
                     |> Enum.map(&to_unicode_font/1)
                     |> List.to_string()}
    end
  end
  def to_unicode_flag({:error, reason}), do: {:error, reason}
  def to_unicode_flag(territory_code), do: territory_code |> Cldr.validate_territory |> to_unicode_flag


  @doc """
  The same as `to_unicode_flag/1`, but raises an exception if it fails.

  ## Example

      iex> Cldr.Territory.to_unicode_flag!(:US)
      "🇺🇸"
  """
  @spec to_unicode_flag!(LanguageTag.t | atom | String.t) :: String.t | Exception.t
  def to_unicode_flag!(%LanguageTag{territory: territory_code}), do: to_unicode_flag!(territory_code)
  def to_unicode_flag!(territory_code) do
    case to_unicode_flag(territory_code) do
      {:ok, result}              -> result

      {:error, {exception, msg}} -> raise exception, msg
    end
  end

  # https://en.wikipedia.org/wiki/Regional_Indicator_Symbol
  defp flag_exists?(territory_code) do
    :"001"
    |> children!()
    |> Enum.map(fn c -> c |> children!() |> Enum.map(&children!/1) end)
    |> List.flatten
    |> Enum.concat([:EU, :UN])
    |> Enum.member?(territory_code)
  end

  # Generates functions that returns the unicode font for A-Z
  for number <- ?A..?Z do
    defp to_unicode_font(unquote(number)), do: [127400 + unquote(number) - 3]
  end

  @doc """
  A helper method to get a territory's currency code
  if a territory has multiply currencies then the oldest active currency is returned.
  Returns `{:ok, code}` if successful, otherwise `{:error, reason}`.

  ## Example

      iex> Cldr.Territory.to_currency_code(:US)
      {:ok, :USD}

      iex> Cldr.Territory.to_currency_code("cu")
      {:ok, :CUP}
  """
  @spec to_currency_code(LanguageTag.t | String.t | atom) :: {:ok, atom} | {:error, {Exception.t, String.t}}
  def to_currency_code(%LanguageTag{territory: territory_code}), do: to_currency_code(territory_code)
  def to_currency_code(territory_code) do
    case info(territory_code) do
      {:error, reason} -> {:error, reason}

      {:ok, territory} -> {:ok, territory |> sort_currency |> Kernel.hd}
    end
  end

  @doc """
  The same as `to_currency_code/1`, but raises an exception if it fails.

  ## Example

      iex> Cldr.Territory.to_currency_code!(:US)
      :USD

      iex> Cldr.Territory.to_currency_code!("PS")
      :ILS
  """
  @spec to_currency_code!(LanguageTag.t | String.t | atom) :: atom | Exception.t
  def to_currency_code!(%LanguageTag{territory: territory_code}), do: to_currency_code(territory_code)
  def to_currency_code!(territory_code) do
    case to_currency_code(territory_code) do
      {:ok, result}              -> result

      {:error, {exception, msg}} -> raise exception, msg
    end
  end

  @doc """
  A helper method to get a territory's currency code.
  Returns `{:ok, list}` if successful, otherwise `{:error, reason}`.

  ## Example

      iex> Cldr.Territory.to_currency_codes(:US)
      {:ok, [:USD]}

      iex> Cldr.Territory.to_currency_codes("cu")
      {:ok, [:CUP, :CUC]}
  """
  @spec to_currency_codes(LanguageTag.t | String.t | atom) :: {:ok, list(atom)} | {:error, {Exception.t, String.t}}
  def to_currency_codes(territory_code) do
    case info(territory_code) do
      {:error, reason} -> {:error, reason}

      {:ok, territory} -> {:ok, sort_currency(territory)}
    end
  end

  @doc """
  The same as `to_currency_codes/1`, but raises an exception if it fails.

  ## Example

      iex> Cldr.Territory.to_currency_codes!(:US)
      [:USD]

      iex> Cldr.Territory.to_currency_codes!("PS")
      [:ILS, :JOD]
  """
  @spec to_currency_codes!(LanguageTag.t | String.t | atom) :: list(atom) | Exception.t
  def to_currency_codes!(territory_code) do
    case to_currency_codes(territory_code) do
      {:ok, result}              -> result

      {:error, {exception, msg}} -> raise exception, msg
    end
  end

  defp sort_currency(%{currency: currency}) do
    currency
    |> Enum.filter(fn {_key, meta} -> !Map.has_key?(meta, :tender) and !Map.has_key?(meta, :to) end)
    |> Enum.sort(&(elem(&1, 1).from < elem(&2, 1).from))
    |> Keyword.keys()
  end

  @regions ["005", "011", "013", "014", "015", "017",
            "018", "021", "029", "030", "034", "035",
            "039", "053", "054", "057", "061", "143",
            "145", "151", "154", "155"]

  @doc """
  Returns a list of country codes.

  ## Example

      iex> Cldr.Territory.country_codes()
      [:AD, :AE, :AF, :AG, :AI, :AL, :AM, :AO, :AR, :AS, :AT, :AU, :AW, :AX, :AZ,
        :BA, :BB, :BD, :BE, :BF, :BG, :BH, :BI, :BJ, :BL, :BM, :BN, :BO, :BQ, :BR,
        :BS, :BT, :BW, :BY, :BZ, :CA, :CD, :CF, :CG, :CH, :CI, :CK, :CL, :CM, :CN,
        :CO, :CR, :CU, :CV, :CW, :CY, :CZ, :DE, :DJ, :DK, :DM, :DO, :DZ, :EA, :EC,
        :EE, :EG, :EH, :ER, :ES, :ET, :FI, :FJ, :FK, :FM, :FO, :FR, :GA, :GB, :GD,
        :GE, :GF, :GG, :GH, :GI, :GL, :GM, :GN, :GP, :GQ, :GR, :GT, :GU, :GW, :GY,
        :HK, :HN, :HR, :HT, :HU, :IC, :ID, :IE, :IL, :IM, :IN, :IQ, :IR, :IS, :IT,
        :JE, :JM, :JO, :JP, :KE, :KG, :KH, :KI, :KM, :KN, :KP, :KR, :KW, :KY, :KZ,
        :LA, :LB, :LC, :LI, :LK, :LR, :LS, :LT, :LU, :LV, :LY, :MA, :MC, :MD, :ME,
        :MF, :MG, :MH, :MK, :ML, :MM, :MN, :MO, :MP, :MQ, :MR, :MS, :MT, :MU, :MV,
        :MW, :MX, :MY, :MZ, :NA, :NC, :NE, :NF, :NG, :NI, :NL, :NO, :NP, :NR, :NU,
        :NZ, :OM, :PA, :PE, :PF, :PG, :PH, :PK, :PL, :PM, :PN, :PR, :PS, :PT, :PW,
        :PY, :QA, :RE, :RO, :RS, :RU, :RW, :SA, :SB, :SC, :SD, :SE, :SG, :SH, :SI,
        :SJ, :SK, :SL, :SM, :SN, :SO, :SR, :SS, :ST, :SV, :SX, :SY, :SZ, :TC, :TD,
        :TG, :TH, :TJ, :TK, :TL, :TM, :TN, :TO, :TR, :TT, :TV, :TW, :TZ, :UA, :UG,
        :US, :UY, :UZ, :VA, :VC, :VE, :VG, :VI, :VN, :VU, :WF, :WS, :XK, :YE, :YT,
        :ZA, :ZM, :ZW]
  """
  @spec country_codes() :: list(atom)
  def country_codes() do
    @regions
    |> Enum.map(&children!/1)
    |> List.flatten
    |> Enum.sort
  end
end
