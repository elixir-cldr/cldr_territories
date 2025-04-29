defmodule Cldr.Territory do
  @moduledoc """
  Supports the CLDR Territories definitions which provide the localization of many
  territories.
  """
  @moduledoc since: "1.0.0"


  alias Cldr.LanguageTag

  @styles [:short, :standard, :variant]
  @territory_containment Cldr.Config.territory_containers()
  @territory_info Cldr.Config.territories()
  @subdivision_aliases Map.new(Map.fetch!(Cldr.Config.aliases(), :subdivision), fn
    {k, v} when is_list(v) -> {:"#{k}", Enum.map(v, &:"#{&1}")}
    {k, v} -> {:"#{k}", :"#{v}"}
  end)

  @doc """
  Returns a list of available styles.

  ## Example

      iex> Cldr.Territory.available_styles()
      [:short, :standard, :variant]
  """
  @doc since: "1.0.0"
  @spec available_styles() :: [:short | :standard | :variant]
  def available_styles(), do: @styles

  @doc """
  Returns a map of available subdivision aliases.

  ## Example

      iex#> Cldr.Territory.subdivision_aliases()
      %{:uspr => :PR}
  """
  @doc since: "2.8.0"
  @spec subdivision_aliases() :: map()
  def subdivision_aliases(), do: @subdivision_aliases

  @doc """
  Returns the available territories for a given locale.

  * `locale` is any configured locale. See `Cldr.known_locale_names/1`.
    The default is `Cldr.get_locale/1`

  ## Example

      => Cldr.Territory.available_territories(TestBackend.Cldr)
      [:"001", :"002", :"003", :"005", :"009", :"011", :"013", :"014", :"015", :"017",
      :"018", :"019", :"021", :"029", :"030", :"034", :"035", :"039", :"053", :"054",
      :"057", :"061", :"142", :"143", :"145", :"150", :"151", :"154", :"155", :"202",
      :"419", :AC, :AD, :AE, :AF, :AG, :AI, :AL, :AM, :AO, :AQ, :AR, :AS, :AT, :AU,
      :AW, :AX, :AZ, :BA, :BB, ...]
  """
  @doc since: "2.0.0"
  @spec available_territories(Cldr.backend()) :: [atom()]
  def available_territories(backend), do: Module.concat(backend, Territory).available_territories()

  @doc """
  Returns the available territory subdivisions for a given locale.

  * `locale` is any configured locale. See `Cldr.known_locale_names/1`.
    The default is `Cldr.get_locale/1`

  ## Example

      => Cldr.Territory.available_subdivisions(TestBackend.Cldr)
      ["ad02", "ad03", "ad04", "ad05", "ad06", "ad07", "ad08", ...]
  """
  @doc since: "2.2.0"
  @spec available_subdivisions(Cldr.backend()) :: [atom()]
  def available_subdivisions(backend), do: Module.concat(backend, Territory).available_subdivisions()

  @doc """
  Returns a map of all known territories in a given locale.

  * `locale` is any configured locale. See `Cldr.known_locale_names/1`.
    The default is `Cldr.get_locale/1`

  ## Example

      => Cldr.Territory.known_territories(TestBackend.Cldr)
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
  """
  @doc since: "2.0.0"
  @spec known_territories(Cldr.backend()) :: map() | {:error, {module(), String.t()}}
  def known_territories(backend), do: Module.concat(backend, Territory).known_territories()

  @doc """
  Returns a map of all known territory subdivisions in a given locale.

  * `locale` is any configured locale. See `Cldr.known_locale_names/1`.
    The default is `Cldr.get_locale/1`

  ## Example

      => Cldr.Territory.known_subdivisions(TestBackend.Cldr)
      %{
        "ad02" => "Canillo",
        "ad03" => "Encamp",
        "ad04" => "La Massana",
        "ad05" => "Ordino",
        "ad06" => "Sant Julià de Lòria",
        "ad07" => "Andorra la Vella",
        ...
  """
  @doc since: "2.0.0"
  @spec known_subdivisions(Cldr.backend()) :: map() | {:error, {module(), String.t()}}
  def known_subdivisions(backend), do: Module.concat(backend, Territory).known_subdivisions()

  @doc """
  Returns a list of subdivisions of a given territory.

  ## Example

      => Cldr.Territory.known_territory_subdivisions(:GB, TestBackend.Cldr)
      {:ok, ["gbabc", "gbabd", "gbabe", "gbagb", "gbagy", "gband", "gbann",
      "gbans", "gbbas", "gbbbd", "gbbdf", "gbbdg", "gbben", "gbbex", "gbbfs",
      "gbbge", "gbbgw", "gbbir", "gbbkm", "gbbmh", "gbbne", "gbbnh", "gbbns",
      "gbbol", "gbbpl", "gbbrc", "gbbrd", "gbbry", "gbbst", "gbbur", "gbcam",
      "gbcay", "gbcbf", "gbccg", "gbcgn", "gbche", "gbchw", "gbcld", "gbclk",
      "gbcma", "gbcmd", "gbcmn", "gbcon", "gbcov", "gbcrf", "gbcry", "gbcwy",
      "gbdal", "gbdby", "gbden", ...]}
  """
  @doc since: "2.2.0"
  @spec known_territory_subdivisions(atom() | String.t() | LanguageTag.t(), Cldr.backend()) :: {:ok, [String.t()] | nil} | {:error, {module(), String.t()}}
  def known_territory_subdivisions(territory_code, backend), do: Module.concat(backend, Territory).known_territory_subdivisions(territory_code)

  @doc """
  Returns the display name for the given territory code.
  Returns `{:ok, String.t}` if successful, otherwise `{:error, reason}`.

  * `options` are:
    * `locale` is any configured locale. See `Cldr.known_locale_names/1`.
      The default is `Cldr.get_locale/1`

    * `backend` is any Cldr backend module. The default is
      `Cldr.default_backend!/0`

    * `style` is one of those returned by `Cldr.Territory.available_styles/0`.
      The current styles are `:short`, `:standard` and `:variant`.
      The default is `:standard`

  If no `:backend` option is specified and no default backend is
  configured an exception will be raised.

  ## Example

      iex> Cldr.Territory.display_name(:GB, backend: TestBackend.Cldr)
      {:ok, "United Kingdom"}

      iex> Cldr.put_default_backend(TestBackend.Cldr)
      iex> Cldr.Territory.display_name(:GB)
      {:ok, "United Kingdom"}

      iex> Cldr.Territory.display_name(:GB, locale: "pt")
      {:ok, "Reino Unido"}

  """
  @doc since: "2.7.0"
  @spec display_name(atom() | String.t() | LanguageTag.t(), Keyword.t()) :: {:ok, String.t()} | {:error, {module(), String.t()}}
  def display_name(territory, options \\ []), do: from_territory_code(territory, Keyword.get_lazy(options, :backend, &Cldr.default_backend!/0), options)

  @doc """
  Localized string for the given territory code.
  Returns `{:ok, String.t}` if successful, otherwise `{:error, reason}`.

  * `options` are:
    * `locale` is any configured locale. See `Cldr.known_locale_names/1`.
      The default is `Cldr.get_locale/1`

    * `style` is one of those returned by `Cldr.Territory.available_styles/0`.
      The current styles are `:short`, `:standard` and `:variant`.
      The default is `:standard`

  ## Example

      iex> Cldr.Territory.from_territory_code(:GB, TestBackend.Cldr)
      {:ok, "United Kingdom"}

      iex> Cldr.Territory.from_territory_code(:GB, TestBackend.Cldr, [style: :short])
      {:ok, "UK"}

      iex> Cldr.Territory.from_territory_code(:GB, TestBackend.Cldr, [style: :ZZZ])
      {:error, {Cldr.UnknownStyleError, "The style :ZZZ is unknown"}}

      iex> Cldr.Territory.from_territory_code(:GB, TestBackend.Cldr, [style: "ZZZ"])
      {:error, {Cldr.UnknownStyleError, "The style \\"ZZZ\\" is unknown"}}

      iex> Cldr.Territory.from_territory_code(:GB, TestBackend.Cldr, [locale: "pt"])
      {:ok, "Reino Unido"}

      iex> Cldr.Territory.from_territory_code(:GB, TestBackend.Cldr, [locale: :zzz])
      {:error, {Cldr.InvalidLanguageError, "The language \\"zzz\\" is invalid"}}

      iex> Cldr.Territory.from_territory_code(:GB, TestBackend.Cldr, [locale: "zzz"])
      {:error, {Cldr.InvalidLanguageError, "The language \\"zzz\\" is invalid"}}

  """
  @doc since: "2.0.0"
  @spec from_territory_code(atom() | String.t() | LanguageTag.t(), Cldr.backend(), Keyword.t()) :: {:ok, String.t()} | {:error, {module(), String.t()}}
  def from_territory_code(code, backend, options \\ []), do: Module.concat(backend, Territory).from_territory_code(code, Keyword.merge([locale: Cldr.get_locale(), style: :standard], options))

  @doc """
  Localized string for the given subdivision code.
  Returns `{:ok, String.t}` if successful, otherwise `{:error, reason}`.

  * `options` are:
    * `locale` is any configured locale. See `Cldr.known_locale_names/1`.
      The default is `Cldr.get_locale/1`

    * `style` is one of those returned by `Cldr.Territory.available_styles/0`.
      The current styles are `:short`, `:standard` and `:variant`.
      The default is `:standard`

  ## Example

      iex> #{inspect __MODULE__}.from_subdivision_code("gbcma", TestBackend.Cldr, locale: "en")
      {:ok, "Cumbria"}

      iex> #{inspect __MODULE__}.from_subdivision_code("gbcma", TestBackend.Cldr, locale: "pl")
      {:ok, "Kumbria"}

      iex> #{inspect __MODULE__}.from_subdivision_code("gbcma", TestBackend.Cldr, locale: "bs")
      {:error, {Cldr.UnknownSubdivisionError, "No subdivision translation for :gbcma could be found in locale :bs"}}

      iex> #{inspect __MODULE__}.from_subdivision_code("invalid", TestBackend.Cldr, locale: "en")
      {:error, {Cldr.UnknownTerritoryError, "The territory \\"invalid\\" is unknown"}}

      iex> #{inspect __MODULE__}.from_subdivision_code("gbcma", TestBackend.Cldr, [locale: :zzz])
      {:error, {Cldr.InvalidLanguageError, "The language \\"zzz\\" is invalid"}}

      iex> #{inspect __MODULE__}.from_subdivision_code("gbcma", TestBackend.Cldr, [locale: "zzz"])
      {:error, {Cldr.InvalidLanguageError, "The language \\"zzz\\" is invalid"}}

  """
  @doc since: "2.2.0"
  @spec from_subdivision_code(String.t(), Cldr.backend(), Keyword.t()) :: {:ok, String.t()} | {:error, {module(), String.t()}}
  def from_subdivision_code(code, backend, options \\ []), do: Module.concat(backend, Territory).from_subdivision_code(code, Keyword.merge([locale: Cldr.get_locale(), style: :standard], options))

  @doc """
  The same as `from_territory_code/2`, but raises an exception if it fails.

  ## Example

      iex> Cldr.Territory.from_territory_code!(:GB, TestBackend.Cldr)
      "United Kingdom"

      iex> Cldr.Territory.from_territory_code!(:GB, TestBackend.Cldr, [style: :short])
      "UK"

      iex> Cldr.Territory.from_territory_code!(:GB, TestBackend.Cldr, [locale: "pt"])
      "Reino Unido"

  """
  @doc since: "2.0.0"
  @spec from_territory_code!(atom() | String.t() | LanguageTag.t(), Cldr.backend(), Keyword.t()) :: String.t()
  def from_territory_code!(code, backend, options \\ []), do: Module.concat(backend, Territory).from_territory_code!(code, Keyword.merge([locale: Cldr.get_locale(), style: :standard], options))

  @doc """
  The same as `from_subdivision_code/2`, but raises an exception if it fails.

  ## Example

      iex> #{inspect __MODULE__}.from_subdivision_code!("gbcma", TestBackend.Cldr, locale: "en")
      "Cumbria"

      iex> #{inspect __MODULE__}.from_subdivision_code!("gbcma", TestBackend.Cldr, locale: "pl")
      "Kumbria"

  """
  @doc since: "2.2.0"
  @spec from_subdivision_code!(String.t(), Cldr.backend(), Keyword.t()) :: String.t()
  def from_subdivision_code!(code, backend, options \\ []), do: Module.concat(backend, Territory).from_subdivision_code!(code, Keyword.merge([locale: Cldr.get_locale(), style: :standard], options))

  @doc """
  Localized string for the given `LanguageTag.t`.
  Returns `{:ok, String.t}` if successful, otherwise `{:error, reason}`.

  * `options` are:
    * `style` is one of those returned by `Cldr.Territory.available_styles/0`.
      The current styles are `:short`, `:standard` and `:variant`.
      The default is `:standard`

  ## Example

      iex> Cldr.Territory.from_language_tag(Cldr.get_locale(TestBackend.Cldr), TestBackend.Cldr)
      {:ok, "world"}

      iex> Cldr.Territory.from_language_tag(Cldr.get_locale(TestBackend.Cldr), TestBackend.Cldr, [style: :short])
      {:error, {Cldr.UnknownStyleError, "The style :short is unknown"}}

      iex> Cldr.Territory.from_language_tag(Cldr.get_locale(TestBackend.Cldr), TestBackend.Cldr, [style: :ZZZ])
      {:error, {Cldr.UnknownStyleError, "The style :ZZZ is unknown"}}

      iex> Cldr.Territory.from_language_tag(Cldr.get_locale(TestBackend.Cldr), TestBackend.Cldr, [style: "ZZZ"])
      {:error, {Cldr.UnknownStyleError, "The style \\"ZZZ\\" is unknown"}}
  """
  @doc since: "2.0.0"
  @spec from_language_tag(LanguageTag.t(), Cldr.backend(), Keyword.t()) :: {:ok, String.t()} | {:error, {module(), String.t()}}
  def from_language_tag(language_tag, backend, options \\ []), do: Module.concat(backend, Territory).from_language_tag(language_tag, Keyword.merge([style: :standard], options))

  @doc """
  The same as `from_language_tag/2`, but raises an exception if it fails.

  ## Example

      iex> Cldr.Territory.from_language_tag!(Cldr.get_locale(TestBackend.Cldr), TestBackend.Cldr)
      "world"
  """
  @doc since: "2.0.0"
  @spec from_language_tag!(LanguageTag.t(), Cldr.backend(), Keyword.t()) :: String.t()
  def from_language_tag!(language_tag, backend, options \\ []), do: Module.concat(backend, Territory).from_language_tag!(language_tag, Keyword.merge([style: :standard], options))

  @doc """
  Translate a localized string from one locale to another.
  Returns `{:ok, result}` if successful, otherwise `{:error, reason}`.

  * `to_locale` is any configured locale. See `Cldr.known_locale_names/1`.
    The default is `Cldr.get_locale/0`

  ## Example

      iex> Cldr.Territory.translate_territory("Reino Unido", "pt", TestBackend.Cldr)
      {:ok, "United Kingdom"}

      iex> Cldr.Territory.translate_territory("United Kingdom", "en", TestBackend.Cldr, "pt")
      {:ok, "Reino Unido"}

      iex> Cldr.Territory.translate_territory("Reino Unido", :zzz, TestBackend.Cldr)
      {:error, {Cldr.InvalidLanguageError, "The language \\"zzz\\" is invalid"}}

      iex> Cldr.Territory.translate_territory("United Kingdom", "en", TestBackend.Cldr, "zzz")
      {:error, {Cldr.InvalidLanguageError, "The language \\"zzz\\" is invalid"}}

  """
  @doc since: "2.0.0"
  @spec translate_territory(String.t(), String.t() | LanguageTag.t(), Cldr.backend(), String.t() | LanguageTag.t(), atom()) :: {:ok, String.t()} | {:error, {module(), String.t()}}
  def translate_territory(localized_string, from_locale, backend \\ Cldr.default_backend!(), to_locale \\ Cldr.get_locale(), style \\ :standard), do: Module.concat(backend, Territory).translate_territory(localized_string, from_locale, to_locale, style)

  @doc """
  Translate a localized string from one locale to another.
  Returns `{:ok, String.t}` if successful, otherwise `{:error, reason}`.

  * `to_locale` is any configured locale. See `Cldr.known_locale_names/1`.
    The default is `Cldr.get_locale/0`

  ## Example

      iex> #{inspect __MODULE__}.translate_subdivision("Cumbria", "en", TestBackend.Cldr, "pl")
      {:ok, "Kumbria"}

      iex> #{inspect __MODULE__}.translate_subdivision("Cumbria", "en", TestBackend.Cldr, "bs")
      {:error, {Cldr.UnknownSubdivisionError, "No subdivision translation for :gbcma could be found in locale :bs"}}

      iex> #{inspect __MODULE__}.translate_subdivision("Cumbria", :zzz, TestBackend.Cldr)
      {:error, {Cldr.InvalidLanguageError, "The language \\"zzz\\" is invalid"}}

      iex> #{inspect __MODULE__}.translate_subdivision("Cumbria", "en", TestBackend.Cldr, "zzz")
      {:error, {Cldr.InvalidLanguageError, "The language \\"zzz\\" is invalid"}}

  """
  @doc since: "2.2.0"
  @spec translate_subdivision(String.t(), String.t() | LanguageTag.t(), Cldr.backend(), String.t() | LanguageTag.t(), atom()) :: {:ok, String.t()} | {:error, {module(), String.t()}}
  def translate_subdivision(localized_string, from_locale, backend, to_locale \\ Cldr.get_locale(), style \\ :standard), do: Module.concat(backend, Territory).translate_subdivision(localized_string, from_locale, to_locale, style)

  @doc """
  The same as `translate_territory/3`, but raises an exception if it fails.

  ## Example

      iex> Cldr.Territory.translate_territory!("Reino Unido", "pt", TestBackend.Cldr)
      "United Kingdom"

      iex> Cldr.Territory.translate_territory!("United Kingdom", "en", TestBackend.Cldr, "pt")
      "Reino Unido"
  """
  @doc since: "2.0.0"
  @spec translate_territory!(String.t(), String.t() | LanguageTag.t(), Cldr.backend(), String.t() | LanguageTag.t(), atom()) :: String.t()
  def translate_territory!(localized_string, from_locale, backend \\ Cldr.default_backend!(), to_locale \\ Cldr.get_locale(), style \\ :standard), do: Module.concat(backend, Territory).translate_territory!(localized_string, from_locale, to_locale, style)

  @doc """
  The same as `translate_subdivision/3`, but raises an exception if it fails.

  ## Example

      iex> #{inspect __MODULE__}.translate_subdivision!("Cumbria", "en", TestBackend.Cldr, "pl")
      "Kumbria"

      #=> #{inspect __MODULE__}.translate_subdivision!("Cumbria", "en", TestBackend.Cldr, "bs")
      ** (Cldr.UnknownSubdivisionError) The locale "bs" has no translation for "gbcma".

  """
  @doc since: "2.2.0"
  @spec translate_subdivision!(String.t(), String.t() | LanguageTag.t(), Cldr.backend(), String.t() | LanguageTag.t(), atom()) :: String.t()
  def translate_subdivision!(localized_string, from_locale, backend, to_locale \\ Cldr.get_locale(), style \\ :standard), do: Module.concat(backend, Territory).translate_subdivision!(localized_string, from_locale, to_locale, style)

  @doc """
  Translate a LanguageTag.t into a localized string from one locale to another.
  Returns `{:ok, String.t}` if successful, otherwise `{:error, reason}`.

  * `options` are:
    * `locale` is any configured locale. See `Cldr.known_locale_names/1`.
      The default is `Cldr.get_locale/0`

    * `style` is one of those returned by `Cldr.Territory.available_styles/0`.
      The current styles are `:short`, `:standard` and `:variant`.
      The default is `:standard`

  ## Example

      iex> Cldr.Territory.translate_language_tag(Cldr.get_locale(), TestBackend.Cldr)
      {:ok, "world"}

      iex> Cldr.Territory.translate_language_tag(Cldr.get_locale(), TestBackend.Cldr, [locale: Cldr.Locale.new!("pt", TestBackend.Cldr)])
      {:ok, "Mundo"}
  """
  @doc since: "2.0.0"
  @spec translate_language_tag(LanguageTag.t(), Cldr.backend(), Keyword.t()) :: {:ok, String.t()} | {:error, {module(), String.t()}}
  def translate_language_tag(from_locale, backend \\ Cldr.default_backend!(), options \\ []) do
    Module.concat(backend, Territory).translate_language_tag(from_locale, Keyword.merge([locale: Cldr.get_locale(), style: :standard], options))
  end

  @doc """
  The same as `translate_language_tag/2`, but raises an exception if it fails.

  ## Example

      iex> Cldr.Territory.translate_language_tag!(Cldr.get_locale(), TestBackend.Cldr)
      "world"

      iex> Cldr.Territory.translate_language_tag!(Cldr.get_locale(), TestBackend.Cldr, [locale: Cldr.Locale.new!("pt", TestBackend.Cldr)])
      "Mundo"
  """
  @doc since: "2.0.0"
  @spec translate_language_tag!(LanguageTag.t(), Cldr.backend(), Keyword.t()) :: String.t()
  def translate_language_tag!(from_locale, backend \\ Cldr.default_backend!(), options \\ []) do
    Module.concat(backend, Territory).translate_language_tag!(from_locale, Keyword.merge([locale: Cldr.get_locale(), style: :standard], options))
  end

  @doc """
  Lists parent(s) for the given territory code.
  Returns `{:ok, list}` if successful, otherwise `{:error, reason}`.

  * `options` are:
    * `as: :atom`
    * `as: :binary`
    * `as: :charlist`

  ## Example

      iex> Cldr.Territory.parent(:GB)
      {:ok, [:"154", :UN]}

      iex> Cldr.Territory.parent(:ZZZ)
      {:error, {Cldr.UnknownTerritoryError, "The territory :ZZZ is unknown"}}

      iex> Cldr.Territory.parent(Cldr.get_locale())
      {:error, {Cldr.UnknownChildrenError, "The territory :\\"001\\" has no parent(s)"}}

  """
  @doc since: "1.0.0"
  @spec parent(atom() | String.t() | LanguageTag.t(), Keyword.t()) :: {:ok, [atom() | LanguageTag.t() | charlist()]} | {:error, {module(), String.t()}}
  def parent(territory_code, options \\ [])
  def parent(%LanguageTag{territory: territory_code}, options), do: parent(territory_code, options)
  for code <- [:UN, :EU, :EZ] do
    def parent(unquote(code), options),  do: {:ok, [as(:"001", options)]}
  end
  def parent(territory_code, options) do
    with {:ok, code} <- Cldr.validate_territory(territory_code),
         [_ | _] = parents <- Enum.sort(for {parent, children} <- @territory_containment, code in children, do: as(parent, options)) do
        {:ok, parents}
    else
      [] -> {:error, {Cldr.UnknownChildrenError, "The territory #{inspect territory_code} has no parent(s)"}}
      error -> error
    end
  end

  @doc """
  The same as `parent/2`, but raises an exception if it fails.

  * `options` are:
    * `as: :atom`
    * `as: :binary`
    * `as: :charlist`

  ## Example

      iex> Cldr.Territory.parent!(:GB)
      [:"154", :UN]

  """
  @doc since: "1.0.0"
  @spec parent!(atom() | String.t() | LanguageTag.t(), Keyword.t()) :: [atom() | LanguageTag.t() | charlist()]
  def parent!(territory_code, options \\ []) do
    case parent(territory_code, options) do
      {:error, {exception, msg}} -> raise exception, msg

      {:ok, result}              -> result
    end
  end


  @doc """
  Lists children(s) for the given territory code.
  Returns `{:ok, list}` if successful, otherwise `{:error, reason}`.

  * `options` are:
    * `as: :atom`
    * `as: :binary`
    * `as: :charlist`

  ## Example

      iex> Cldr.Territory.children(:EU)
      {:ok,
       [:AT, :BE, :CY, :CZ, :DE, :DK, :EE, :ES, :FI, :FR, :GR, :HR, :HU, :IE,
        :IT, :LT, :LU, :LV, :MT, :NL, :PL, :PT, :SE, :SI, :SK, :BG, :RO]}

      iex> Cldr.Territory.children(:ZZZ)
      {:error, {Cldr.UnknownTerritoryError, "The territory :ZZZ is unknown"}}

      iex> Cldr.Territory.children(:GB)
      {:error, {Cldr.UnknownParentError, "The territory :GB has no children"}}

  """
  @doc since: "1.0.0"
  @spec children(atom() | String.t() | LanguageTag.t(), Keyword.t()) :: {:ok, [atom() | LanguageTag.t() | charlist()]} | {:error, {module(), String.t()}}
  def children(territory_code, options \\ [])
  def children(%LanguageTag{territory: territory_code}, options),  do: children(territory_code, options)
  def children(territory_code, options) do
    with {:ok, code} <- Cldr.validate_territory(territory_code),
        %{^code =>  [_ | _] = children} <- @territory_containment do
          {:ok, Enum.map(children, &as(&1, options))}
    else
      %{} -> {:error, {Cldr.UnknownParentError, "The territory #{inspect territory_code} has no children"}}
      error -> error
    end
  end

  @doc """
  The same as `children/2`, but raises an exception if it fails.

  * `options` are:
    * `as: :atom`
    * `as: :binary`
    * `as: :charlist`

  ## Example

      iex> Cldr.Territory.children!(:EU)
      [:AT, :BE, :CY, :CZ, :DE, :DK, :EE, :ES, :FI, :FR, :GR, :HR, :HU, :IE, :IT,
       :LT, :LU, :LV, :MT, :NL, :PL, :PT, :SE, :SI, :SK, :BG, :RO]

  """
  @doc since: "1.0.0"
  @spec children!(atom() | String.t() | LanguageTag.t(), Keyword.t()) :: [atom() |  LanguageTag.t() | charlist()]
  def children!(territory_code, options \\ []) do
    case children(territory_code, options) do
      {:error, {exception, msg}} -> raise exception, msg

      {:ok, result}              -> result
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
  @doc since: "1.0.0"
  @spec contains?(atom() | LanguageTag.t(), atom() | LanguageTag.t()) :: boolean()
  def contains?(%LanguageTag{territory: parent}, child), do: contains?(parent, child)
  def contains?(parent, %LanguageTag{territory: child}), do: contains?(parent, child)
  def contains?(parent, child) do
    case @territory_containment do
      %{^parent => children} -> child in children
      _ -> false
    end
  end

  @doc """
  Maps territory info for the given territory code.
  Returns `{:ok, map}` if successful, otherwise `{:error, reason}`.

  ## Example

      iex> Cldr.Territory.info(:GB)
      {:ok,
       %{
         currency: [GBP: %{from: ~D[1694-07-27]}],
         gdp: 2925000000000,
         language_population: %{
          "ar" => %{population_percent: 0.3},
          "bn" => %{population_percent: 0.4},
          "cy" => %{official_status: "official_regional", population_percent: 1.3},
          "de" => %{population_percent: 9},
          "en" => %{official_status: "official", population_percent: 98},
          "es" => %{population_percent: 8},
          "fr" => %{population_percent: 23},
          "ga" => %{official_status: "official_regional", population_percent: 0.15},
          "gd" => %{
            official_status: "official_regional",
            population_percent: 0.11,
            writing_percent: 5
          },
          "gu" => %{population_percent: 2.9},
          "it" => %{population_percent: 0.2},
          "kw" => %{population_percent: 0.003},
          "lt" => %{population_percent: 0.2},
          "pa" => %{population_percent: 3.6},
          "pl" => %{population_percent: 4},
          "pt" => %{population_percent: 0.2},
          "sco" => %{population_percent: 2.5, writing_percent: 5},
          "so" => %{population_percent: 0.2},
          "ta" => %{population_percent: 3.2},
          "tr" => %{population_percent: 0.2},
          "ur" => %{population_percent: 3.5},
          "zh-Hant" => %{population_percent: 0.3},
          "en-Shaw" => %{population_percent: 0}
         },
         literacy_percent: 99,
         measurement_system: %{
           default: :uksystem,
           paper_size: :a4,
           temperature: :uksystem
         },
         population: 65761100
       }}

      iex> Cldr.Territory.info(:"155")
      {:error,
       {Cldr.UnknownInformationError, "No information available for :\\"155\\""}}

  """
  @doc since: "1.0.0"
  @spec info(atom() | String.t() | LanguageTag.t()) :: {:ok, map()} | {:error, {module(), String.t()}}
  def info(%LanguageTag{territory: territory_code}), do: info(territory_code)
  def info(territory_code) do
    case Cldr.validate_territory(territory_code) do
      {:error, reason} -> {:error, reason}

      {:ok, code}      ->
        info = @territory_info[code]
        if info, do: {:ok, info}, else: {:error, {Cldr.UnknownInformationError, "No information available for #{inspect code}"}}
    end
  end

  @doc """
  The same as `info/1`, but raises an exception if it fails.

  ## Example

      iex> Cldr.Territory.info!(:GB)
      %{
        currency: [GBP: %{from: ~D[1694-07-27]}],
        gdp: 2925000000000,
        language_population: %{
          "ar" => %{population_percent: 0.3},
          "bn" => %{population_percent: 0.4},
          "cy" => %{official_status: "official_regional", population_percent: 1.3},
          "de" => %{population_percent: 9},
          "en" => %{official_status: "official", population_percent: 98},
          "es" => %{population_percent: 8},
          "fr" => %{population_percent: 23},
          "ga" => %{official_status: "official_regional", population_percent: 0.15},
          "gd" => %{
            official_status: "official_regional",
            population_percent: 0.11,
            writing_percent: 5
          },
          "gu" => %{population_percent: 2.9},
          "it" => %{population_percent: 0.2},
          "kw" => %{population_percent: 0.003},
          "lt" => %{population_percent: 0.2},
          "pa" => %{population_percent: 3.6},
          "pl" => %{population_percent: 4},
          "pt" => %{population_percent: 0.2},
          "sco" => %{population_percent: 2.5, writing_percent: 5},
          "so" => %{population_percent: 0.2},
          "ta" => %{population_percent: 3.2},
          "tr" => %{population_percent: 0.2},
          "ur" => %{population_percent: 3.5},
          "zh-Hant" => %{population_percent: 0.3},
          "en-Shaw" => %{population_percent: 0}
        },
        literacy_percent: 99,
        measurement_system: %{
          default: :uksystem,
          paper_size: :a4,
          temperature: :uksystem
        },
        population: 65761100
      }
  """
  @doc since: "1.0.0"
  @spec info!(atom() | String.t() | LanguageTag.t()) :: map()
  def info!(territory_code) do
    case info(territory_code) do
      {:error, {exception, msg}} -> raise exception, msg

      {:ok, result}              -> result
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
  @doc since: "1.0.0"
  @spec to_unicode_flag(atom() | String.t() | LanguageTag.t()) :: {:ok, String.t()} | {:error, {module(), String.t()}}
  def to_unicode_flag(%LanguageTag{territory: territory_code}), do: to_unicode_flag(territory_code)
  def to_unicode_flag(territory_code) do
    with {:ok, code} <- Cldr.validate_territory(territory_code),
                true <- flag_exists?(code) do
                  {:ok, Enum.map_join(~c"#{territory_code}", "", &to_unicode_font/1)}
    else
      false -> {:error, {Cldr.UnknownFlagError, "The territory #{inspect territory_code} has no flag"}}
      error -> error
    end
  end


  @doc """
  The same as `to_unicode_flag/1`, but raises an exception if it fails.

  ## Example

      iex> Cldr.Territory.to_unicode_flag!(:US)
      "🇺🇸"
  """
  @doc since: "1.0.0"
  @spec to_unicode_flag!(atom() | String.t() | LanguageTag.t()) :: String.t()
  def to_unicode_flag!(territory_code) do
    case to_unicode_flag(territory_code) do
      {:error, {exception, msg}} -> raise exception, msg

      {:ok, result}              -> result
    end
  end

  # https://en.wikipedia.org/wiki/Regional_Indicator_Symbol
  defp flag_exists?(territory_code) do
    :"001"
    |> children!()
    |> Enum.flat_map(fn c -> Enum.flat_map(children!(c), &children!/1) end)
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

  * `options` are:
    * `as: :atom`
    * `as: :binary`
    * `as: :charlist`

  ## Example

      iex> Cldr.Territory.to_currency_code(:US)
      {:ok, :USD}

      iex> Cldr.Territory.to_currency_code("cu")
      {:ok, :CUP}

      iex> Cldr.Territory.to_currency_code(:CQ)
      {:error, {Cldr.UnknownCurrencyError, "No currencies for :CQ were found"}}
  """
  @doc since: "1.2.0"
  @spec to_currency_code(atom() | String.t() | LanguageTag.t(), Keyword.t()) :: {:ok, atom() | String.t() | charlist()} | {:error, {module(), String.t()}}
  def to_currency_code(territory_code, options \\ [])
  def to_currency_code(%LanguageTag{territory: territory_code}, options), do: to_currency_code(territory_code, options)
  def to_currency_code(territory_code, options) do
    case to_currency_codes(territory_code, options) do
      {:error, reason} -> {:error, reason}

      {:ok, [code | _]} -> {:ok, code}

      {:ok, []} -> {:error, {Cldr.UnknownCurrencyError, "No currencies for #{inspect territory_code} were found"}}
    end
  end

  @doc """
  The same as `to_currency_code/2`, but raises an exception if it fails.

  * `options` are:
    * `as: :atom`
    * `as: :binary`
    * `as: :charlist`

  ## Example

      iex> Cldr.Territory.to_currency_code!(:US)
      :USD

      iex> Cldr.Territory.to_currency_code!(:US, as: :charlist)
      ~c"USD"

      iex> Cldr.Territory.to_currency_code!("PS")
      :ILS

      iex> Cldr.Territory.to_currency_code!("PS", as: :binary)
      "ILS"
  """
  @doc since: "1.2.0"
  @spec to_currency_code!(atom() | String.t() | LanguageTag.t(), Keyword.t()) :: atom() | String.t() | charlist()
  def to_currency_code!(territory_code, options \\ [])
  def to_currency_code!(%LanguageTag{territory: territory_code}, options), do: to_currency_code!(territory_code, options)
  def to_currency_code!(territory_code, options) do
    case to_currency_code(territory_code, options) do
      {:error, {exception, msg}} -> raise exception, msg

      {:ok, result}              -> result
    end
  end

  @doc """
  A helper method to get a territory's currency codes.
  Returns `{:ok, list}` if successful, otherwise `{:error, reason}`.

  * `options` are:
    * `as: :atom`
    * `as: :binary`
    * `as: :charlist`

  ## Example

      iex> Cldr.Territory.to_currency_codes(:US)
      {:ok, [:USD]}

      iex> Cldr.Territory.to_currency_codes("ht")
      {:ok, [:USD, :HTG]}
  """
  @doc since: "1.2.0"
  @spec to_currency_codes(atom() | String.t() | LanguageTag.t(), Keyword.t()) :: {:ok, [atom() | String.t() | charlist()]} | {:error, {module(), String.t()}}
  def to_currency_codes(territory_code, options \\ [])
  def to_currency_codes(territory_code, options) do
    case info(territory_code) do
      {:error, reason} -> {:error, reason}

      {:ok, %{currency: currency}} -> {:ok, (for {k, meta} <- currency, !Map.has_key?(meta, :tender) and !Map.has_key?(meta, :to), do: {as(k, options), meta})
                                            |> Enum.sort(&(elem(&1, 1).from < elem(&2, 1).from))
                                            |> Enum.map(&elem(&1, 0))}
    end
  end

  @doc """
  The same as `to_currency_codes/2`, but raises an exception if it fails.

  * `options` are:
    * `as: :atom`
    * `as: :binary`
    * `as: :charlist`

  ## Example

      iex> Cldr.Territory.to_currency_codes!(:US)
      [:USD]

      iex> Cldr.Territory.to_currency_codes!(:US, as: :charlist)
      [~c"USD"]

      iex> Cldr.Territory.to_currency_codes!("PS")
      [:ILS, :JOD]

      iex> Cldr.Territory.to_currency_codes!("PS", as: :binary)
      ["ILS", "JOD"]
  """
  @doc since: "1.2.0"
  @spec to_currency_codes!(atom() | String.t() | LanguageTag.t(), Keyword.t()) :: [atom() | String.t() | charlist()]
  def to_currency_codes!(territory_code, options \\ [])
  def to_currency_codes!(territory_code, options) do
    case to_currency_codes(territory_code, options) do
      {:error, {exception, msg}} -> raise exception, msg

      {:ok, result}              -> result
    end
  end

  @regions ["005", "011", "013", "014", "015", "017",
            "018", "021", "029", "030", "034", "035",
            "039", "053", "054", "057", "061", "143",
            "145", "151", "154", "155"]

  @doc """
  Returns a list of country codes.

  * `options` are:
    * `as: :atom`
    * `as: :binary`
    * `as: :charlist`

  ## Example

      => Cldr.Territory.country_codes()
      [:AD, :AE, :AF, :AG, :AI, :AL, :AM, :AO, :AR, :AS, :AT, :AU, :AW,
       :AX, :AZ, :BA, :BB, :BD, :BE, :BF, :BG, :BH, :BI, :BJ, :BL, :BM,
       :BN, :BO, :BQ, :BR, :BS, :BT, :BV, :BW, :BY, :BZ, :CA, :CC, :CD,
       :CF, :CG, :CH, :CI, :CK, :CL, :CM, :CN, :CO, :CR, :CU, ...]
  """
  @doc since: "1.2.0"
  @spec country_codes(Keyword.t()) :: [atom() | String.t() | charlist()]
  def country_codes(options \\ []) do
    @regions
    |> Enum.flat_map(&children!/1)
    |> Enum.sort()
    |> Enum.map(&as(&1, options))
  end

  @doc """
  Converts a territory name in a given locale to a territory code.
  Returns `{:ok, territory_code}` if successful, otherwise `{:error, reason}`.

  * `territory_name` is the localized territory name
  * `locale` is any configured locale. See `Cldr.known_locale_names/1`.
    The default is `Cldr.get_locale/0`
  * `options` are:
    * `as: :atom` 
    * `as: :binary`
    * `as: :charlist`

  ## Example

      iex> Cldr.Territory.to_territory_code("United Kingdom", "en", TestBackend.Cldr)
      {:ok, :GB}

      iex> Cldr.Territory.to_territory_code("Reino Unido", "pt", TestBackend.Cldr)
      {:ok, :GB}

      iex> Cldr.Territory.to_territory_code("Unknown Country", "en", TestBackend.Cldr)
      {:error, {Cldr.UnknownTerritoryError, "No territory code for \\"Unknown Country\\" could be found in locale :en"}}
  """
  @doc since: "2.10.0"
  @spec to_territory_code(String.t(), String.t() | LanguageTag.t(), Cldr.backend(), Keyword.t()) :: {:ok, atom() | String.t() | charlist()} | {:error, {module(), String.t()}}
  def to_territory_code(territory_name, locale, backend \\ Cldr.default_backend!(), options \\ []) do
    with {:ok, locale} <- Cldr.validate_locale(locale, backend) do
      normalized_name = normalize_name(territory_name)
      inverted_territories = Module.concat(backend, Territory).inverted_territories(locale.cldr_locale_name)
      
      case inverted_territories do
        %{^normalized_name => territory_code} -> {:ok, as(territory_code, options)}
        _ -> {:error, {Cldr.UnknownTerritoryError, "No territory code for #{inspect territory_name} could be found in locale #{inspect locale.cldr_locale_name}"}}
      end
    end
  end

  @doc """
  The same as `to_territory_code/3`, but raises an exception if it fails.

  ## Example

      iex> Cldr.Territory.to_territory_code!("United Kingdom", "en", TestBackend.Cldr)
      :GB

      iex> Cldr.Territory.to_territory_code!("Reino Unido", "pt", TestBackend.Cldr, as: :binary)
      "GB"
  """
  @doc since: "2.10.0"
  @spec to_territory_code!(String.t(), String.t() | LanguageTag.t(), Cldr.backend(), Keyword.t()) :: atom() | String.t() | charlist()
  def to_territory_code!(territory_name, locale, backend \\ Cldr.default_backend!(), options \\ []) do
    case to_territory_code(territory_name, locale, backend, options) do
      {:error, {exception, msg}} -> raise exception, msg
      {:ok, result} -> result
    end
  end

  @doc false
  def normalize_name(string) do
    string
    |> String.downcase()
    |> String.replace(" & ", "")
    |> String.replace(".", "")
    |> String.replace(~r/(\s)+/u, "\\1")
  end

  @doc """
  Converts a territory code to a specified format.
  
  * `options` are:
    * `as: :atom` (default)
    * `as: :binary`
    * `as: :charlist`
    
  ## Example
  
      iex> Cldr.Territory.as(:GB, [as: :atom])
      :GB
      
      iex> Cldr.Territory.as(:GB, [as: :binary])
      "GB"
      
      iex> Cldr.Territory.as(:GB, [as: :charlist])
      ~c"GB"
  """
  @doc since: "2.10.0"
  @spec as(atom() | String.t(), Keyword.t()) :: atom() | String.t() | charlist()
  def as(value, options \\ [as: :atom])
  def as(value, [as: :atom]), do: :"#{value}"
  def as(value, [as: :binary]), do: "#{value}"
  def as(value, [as: :charlist]), do: ~c"#{value}"
  def as(value, _options), do: as(value, [as: :atom])
end
