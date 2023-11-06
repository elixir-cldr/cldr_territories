defmodule Cldr.Territory.Backend do
  @moduledoc false
  def define_territory_module(config) do
    module = inspect(__MODULE__)
    backend = config.backend
    config = Macro.escape(config)

    quote location: :keep, bind_quoted: [module: module, backend: backend, config: config] do
      defmodule Territory do
        alias Cldr.Locale

        @doc """
        Returns a list of available styles.

        ## Example

            iex> #{inspect __MODULE__}.available_styles()
            [:short, :standard, :variant]

        """
        @doc since: "2.0.0"
        @spec available_styles() :: [:short | :standard | :variant]
        def available_styles(), do: Cldr.Territory.available_styles()

        @doc """
        Returns a map of available subdivision aliases.

        ## Example

            iex#> #{inspect __MODULE__}.subdivision_aliases()
            %{:uspr => :PR}

        """
        @doc since: "2.8.0"
        @spec subdivision_aliases() :: map()
        def subdivision_aliases(), do: Cldr.Territory.subdivision_aliases()

        @doc """
        Returns the available territories for a given locale.

        * `locale` is any configured locale. See `#{inspect backend}.known_locale_names/0`.
          The default is `Cldr.get_locale/0`

        ## Example

            => #{inspect __MODULE__}.available_territories()
            [:"001", :"002", :"003", :"005", :"009", :"011", :"013", :"014", :"015", :"017",
            :"018", :"019", :"021", :"029", :"030", :"034", :"035", :"039", :"053", :"054",
            :"057", :"061", :"142", :"143", :"145", :"150", :"151", :"154", :"155", :"202",
            :"419", :AC, :AD, :AE, :AF, :AG, :AI, :AL, :AM, :AO, :AQ, :AR, :AS, :AT, :AU,
            :AW, :AX, :AZ, :BA, :BB, ...]

            iex> #{inspect __MODULE__}.available_territories("zzz")
            {:error, {Cldr.InvalidLanguageError, "The language \\"zzz\\" is invalid"}}

        """
        @doc since: "2.0.0"
        @spec available_territories(atom() | String.t() | LanguageTag.t()) :: [atom()] | {:error, {module(), String.t()}}
        def available_territories(locale \\ Cldr.get_locale())
        def available_territories(%LanguageTag{} = language_tag), do: available_territories(language_tag.cldr_locale_name)

        @doc """
        Returns the available territory subdivisions for a given locale.

        * `locale` is any configured locale. See `#{inspect backend}.known_locale_names/0`.
          The default is `Cldr.get_locale/0`

        ## Example

            => #{inspect __MODULE__}.available_subdivisions("en")
            [:ad02, :ad03, :ad04, :ad05, :ad06, :ad07, :ad08, ...]

            iex> #{inspect __MODULE__}.available_subdivisions()
            []

            iex> #{inspect __MODULE__}.available_subdivisions("zzz")
            {:error, {Cldr.InvalidLanguageError, "The language \\"zzz\\" is invalid"}}

        """
        @doc since: "2.2.0"
        @spec available_subdivisions(atom() | String.t() | LanguageTag.t()) :: [atom()] | {:error, {module(), String.t()}}
        def available_subdivisions(locale \\ Cldr.get_locale())
        def available_subdivisions(%LanguageTag{} = language_tag), do: available_subdivisions(language_tag.cldr_locale_name)

        @doc """
        Returns a map of all known territories in a given locale.

        * `locale` is any configured locale. See `#{inspect backend}.known_locale_names/0`.
          The default is `Cldr.get_locale/0`

        ## Example

            => #{inspect __MODULE__}.known_territories()
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

            => #{inspect __MODULE__}.known_territories("zzz")
            {:error, {Cldr.InvalidLanguageError, "The language \"zzz\" is invalid"}}

        """
        @doc since: "2.0.0"
        @spec known_territories(atom() | String.t() | LanguageTag.t()) :: map() | {:error, {module(), String.t()}}
        def known_territories(locale \\ Cldr.get_locale())
        def known_territories(%LanguageTag{} = language_tag), do: known_territories(language_tag.cldr_locale_name)

        @doc """
        Returns a map of all known territory subdivisions in a given locale.

        * `locale` is any configured locale. See `#{inspect backend}.known_locale_names/0`.
          The default is `Cldr.get_locale/0`

        ## Example

            => #{inspect __MODULE__}.known_subdivisions("en")
            %{
              "ad02" => "Canillo",
              "ad03" => "Encamp",
              "ad04" => "La Massana",
              "ad05" => "Ordino",
              "ad06" => "Sant Julià de Lòria",
              "ad07" => "Andorra la Vella",
              ...

            iex> #{inspect __MODULE__}.known_subdivisions()
            %{}

            iex> #{inspect __MODULE__}.known_subdivisions("zzz")
            {:error, {Cldr.InvalidLanguageError, "The language \\"zzz\\" is invalid"}}

        """
        @doc since: "2.2.0"
        @spec known_subdivisions(atom() | String.t() | LanguageTag.t()) :: map() | {:error, {module(), String.t()}}
        def known_subdivisions(locale \\ Cldr.get_locale())
        def known_subdivisions(%LanguageTag{} = language_tag), do: known_subdivisions(language_tag.cldr_locale_name)

        @doc """
        Returns a list of subdivisions of a given territory.

        ## Example

            => #{inspect __MODULE__}.known_territory_subdivisions(:GB)
            {:ok, ["gbabc", "gbabd", "gbabe", "gbagb", "gbagy", "gband", "gbann",
            "gbans", "gbbas", "gbbbd", "gbbdf", "gbbdg", "gbben", "gbbex", "gbbfs",
            "gbbge", "gbbgw", "gbbir", "gbbkm", "gbbmh", "gbbne", "gbbnh", "gbbns",
            "gbbol", "gbbpl", "gbbrc", "gbbrd", "gbbry", "gbbst", "gbbur", "gbcam",
            "gbcay", "gbcbf", "gbccg", "gbcgn", "gbche", "gbchw", "gbcld", "gbclk",
            "gbcma", "gbcmd", "gbcmn", "gbcon", "gbcov", "gbcrf", "gbcry", "gbcwy",
            "gbdal", "gbdby", "gbden", ...]}

            iex> #{inspect __MODULE__}.known_territory_subdivisions(:ZZZ)
            {:error, {Cldr.UnknownTerritoryError, "The territory :ZZZ is unknown"}}

        """
        @doc since: "2.2.0"
        @spec known_territory_subdivisions(atom() | String.t() | LanguageTag.t()) :: {:ok, String.t()} | {:error, {module(), String.t()}}
        def known_territory_subdivisions(territory_code) do
          case Cldr.validate_territory(territory_code) do
            {:error, reason}      -> {:error, reason}
            {:ok, territory_code} -> {:ok, Cldr.known_territory_subdivisions()[territory_code]}
          end
        end

        @doc """
        Localized string for the given territory code.
        Returns `{:ok, String.t}` if successful, otherwise `{:error, reason}`.

        * `options` are:
          * `locale` is any configured locale. See `#{inspect backend}.known_locale_names/0`.
            The default is `Cldr.get_locale/0`

          * `style` is one of those returned by `#{inspect __MODULE__}.available_styles/0`.
            The current styles are `:short`, `:standard` and `:variant`.
            The default is `:standard`

        ## Example

            iex> #{inspect __MODULE__}.from_territory_code(:GB)
            {:ok, "United Kingdom"}

            iex> #{inspect __MODULE__}.from_territory_code(:GB, [style: :short])
            {:ok, "UK"}

            iex> #{inspect __MODULE__}.from_territory_code(:GB, [style: :ZZZ])
            {:error, {Cldr.UnknownStyleError, "The style :ZZZ is unknown"}}

            iex> #{inspect __MODULE__}.from_territory_code(:GB, [style: "ZZZ"])
            {:error, {Cldr.UnknownStyleError, "The style \\"ZZZ\\" is unknown"}}

            iex> #{inspect __MODULE__}.from_territory_code(:GB, [locale: "pt"])
            {:ok, "Reino Unido"}

            iex> #{inspect __MODULE__}.from_territory_code(:GB, [locale: :zzz])
            {:error, {Cldr.InvalidLanguageError, "The language \\"zzz\\" is invalid"}}

            iex> #{inspect __MODULE__}.from_territory_code(:GB, [locale: "zzz"])
            {:error, {Cldr.InvalidLanguageError, "The language \\"zzz\\" is invalid"}}

        """
        @doc since: "2.0.0"
        @spec from_territory_code(atom() | String.t() | LanguageTag.t(), Keyword.t()) :: {:ok, String.t()} | {:error, {module(), String.t()}}
        def from_territory_code(territory_code, options \\ []) do
          with {:ok, code} <- Cldr.validate_territory(territory_code),
               {:ok, local} <- Cldr.validate_locale(Keyword.get(options, :locale, Cldr.get_locale()), unquote(backend)) do
            from_territory_code(code, local.cldr_locale_name, Keyword.get(options, :style, :standard))
          else
            error -> error
          end
        end

        @doc """
        Localized string for the given subdivision code.
        Returns `{:ok, String.t}` if successful, otherwise `{:error, reason}`.

        * `options` are:
          * `locale` is any configured locale. See `#{inspect backend}.known_locale_names/0`.
            The default is `Cldr.get_locale/0`

          * `style` is one of those returned by `#{inspect __MODULE__}.available_styles/0`.
            The current styles are `:short`, `:standard` and `:variant`.
            The default is `:standard`

        ## Example

            iex> #{inspect __MODULE__}.from_subdivision_code("gbcma", locale: "en")
            {:ok, "Cumbria"}

            iex> #{inspect __MODULE__}.from_subdivision_code("gbcma", locale: "pl")
            {:ok, "Kumbria"}

            iex> #{inspect __MODULE__}.from_subdivision_code("gbcma", locale: "bs")
            {:error, {Cldr.UnknownSubdivisionError, "No subdivision translation for :gbcma could be found in locale :bs"}}

            iex> #{inspect __MODULE__}.from_subdivision_code("invalid", locale: "en")
            {:error, {Cldr.UnknownTerritoryError, "The territory \\"invalid\\" is unknown"}}

            iex> #{inspect __MODULE__}.from_subdivision_code("gbcma", [locale: :zzz])
            {:error, {Cldr.InvalidLanguageError, "The language \\"zzz\\" is invalid"}}

            iex> #{inspect __MODULE__}.from_subdivision_code("gbcma", [locale: "zzz"])
            {:error, {Cldr.InvalidLanguageError, "The language \\"zzz\\" is invalid"}}

        """
        @doc since: "2.2.0"
        @spec from_subdivision_code(atom() | String.t() | LanguageTag.t(), Keyword.t()) :: {:ok, String.t()} | {:error, {module(), String.t()}}
        def from_subdivision_code(subdivision_code, options \\ []) do
          with {:ok, code} <- Cldr.validate_territory_subdivision(subdivision_code),
               {:ok, local} <- Cldr.validate_locale(Keyword.get(options, :locale, Cldr.get_locale()), unquote(backend)) do
                from_subdivision_code(code, local.cldr_locale_name, Keyword.get(options, :style, :standard))
          else
            error -> error
          end
        end

        @doc """
        The same as `from_territory_code/2`, but raises an exception if it fails.

        ## Example

            iex> #{inspect __MODULE__}.from_territory_code!(:GB)
            "United Kingdom"

            iex> #{inspect __MODULE__}.from_territory_code!(:GB, [style: :short])
            "UK"

            iex> #{inspect __MODULE__}.from_territory_code!(:GB, [locale: "pt"])
            "Reino Unido"

        """
        @doc since: "2.0.0"
        @spec from_territory_code!(atom() | String.t() | LanguageTag.t(), Keyword.t()) :: String.t()
        def from_territory_code!(territory_code, options \\ []) do
          case from_territory_code(territory_code, options) do
            {:error, {exception, msg}} -> raise exception, msg
            {:ok, result}              -> result
          end
        end

        @doc """
        The same as `from_subdivision_code/2`, but raises an exception if it fails.

        ## Example

            iex> #{inspect __MODULE__}.from_subdivision_code!("gbcma", locale: "en")
            "Cumbria"

            iex> #{inspect __MODULE__}.from_subdivision_code!("gbcma", locale: "pl")
            "Kumbria"

        """
        @doc since: "2.2.0"
        @spec from_subdivision_code!(atom() | String.t() | LanguageTag.t(), Keyword.t()) :: String.t()
        def from_subdivision_code!(subdivision_code, options \\ []) do
          case from_subdivision_code(subdivision_code, options) do
            {:error, {exception, msg}} -> raise exception, msg
            {:ok, result}              -> result
          end
        end


        @doc """
        Localized string for the given `LanguageTag.t`.
        Returns `{:ok, String.t}` if successful, otherwise `{:error, reason}`.

        * `options` are:
          * `style` is one of those returned by `#{inspect __MODULE__}.available_styles/0`.
            The current styles are `:short`, `:standard` and `:variant`.
            The default is `:standard`

        ## Example

            iex> #{inspect __MODULE__}.from_language_tag(Cldr.get_locale())
            {:ok, "world"}

            iex> #{inspect __MODULE__}.from_language_tag(Cldr.get_locale(), [style: :short])
            {:error, {Cldr.UnknownStyleError, "The style :short is unknown"}}

            iex> #{inspect __MODULE__}.from_language_tag(Cldr.get_locale(), [style: :ZZZ])
            {:error, {Cldr.UnknownStyleError, "The style :ZZZ is unknown"}}

            iex> #{inspect __MODULE__}.from_language_tag(Cldr.get_locale(), [style: "ZZZ"])
            {:error, {Cldr.UnknownStyleError, "The style \\"ZZZ\\" is unknown"}}

        """
        @doc since: "2.0.0"
        @spec from_language_tag(LanguageTag.t(), Keyword.t()) :: {:ok, String.t()} | {:error, {module(), String.t()}}
        def from_language_tag(language_tag, options \\ [])
        def from_language_tag(%LanguageTag{} = language_tag, options) do
          from_territory_code(language_tag.territory, Keyword.merge(options, [locale: language_tag.cldr_locale_name]))
        end
        def from_language_tag(language_tag, _options), do: unknown_language_tag_error(language_tag)

        @doc """
        The same as `from_language_tag/2`, but raises an exception if it fails.

        ## Example

            iex> #{inspect __MODULE__}.from_language_tag!(Cldr.get_locale())
            "world"

        """
        @doc since: "2.0.0"
        @spec from_language_tag!(LanguageTag.t(), Keyword.t()) :: String.t()
        def from_language_tag!(language_tag, options \\ [])
        def from_language_tag!(language_tag, options) do
          case from_language_tag(language_tag, options) do
            {:ok, string} -> string
            {:error, {exception, message}} -> raise(exception, message)
          end
        end

        @doc """
        Translate a localized string from one locale to another.
        Returns `{:ok, String.t}` if successful, otherwise `{:error, reason}`.

        * `to_locale` is any configured locale. See `#{inspect backend}.known_locale_names/0`.
          The default is `Cldr.get_locale/0`

        ## Example

            iex> #{inspect __MODULE__}.translate_territory("Reino Unido", "pt")
            {:ok, "United Kingdom"}

            iex> #{inspect __MODULE__}.translate_territory("United Kingdom", "en", "pt")
            {:ok, "Reino Unido"}

            iex> #{inspect __MODULE__}.translate_territory("Reino Unido", :zzz)
            {:error, {Cldr.InvalidLanguageError, "The language \\"zzz\\" is invalid"}}

            iex> #{inspect __MODULE__}.translate_territory("United Kingdom", "en", "zzz")
            {:error, {Cldr.InvalidLanguageError, "The language \\"zzz\\" is invalid"}}

            iex> #{inspect __MODULE__}.translate_territory("Westworld", "en", "pt")
            {:error, {Cldr.UnknownTerritoryError, "No territory translation for \\"Westworld\\" could be found in locale :en"}}

        """
        @doc since: "2.0.0"
        @spec translate_territory(String.t(), atom() | String.t() | LanguageTag.t(), atom() | String.t() | LanguageTag.t(), atom()) :: {:ok, String.t()} | {:error, {module(), String.t()}}
        def translate_territory(localized_string, from_locale, to_locale \\ Cldr.get_locale(), style \\ :standard)
        def translate_territory(localized_string, %LanguageTag{cldr_locale_name: from_locale}, to_locale, style) do
          translate_territory(localized_string, from_locale, to_locale, style)
        end
        def translate_territory(localized_string, from_locale, %LanguageTag{cldr_locale_name: to_locale}, style) do
          translate_territory(localized_string, from_locale, to_locale, style)
        end

        @doc """
        Translate a localized string from one locale to another.
        Returns `{:ok, result}` if successful, otherwise `{:error, reason}`.

        * `to_locale` is any configured locale. See `#{inspect backend}.known_locale_names/0`.
          The default is `Cldr.get_locale/0`

        ## Example

            iex> #{inspect __MODULE__}.translate_subdivision("Cumbria", "en", "pl")
            {:ok, "Kumbria"}

            iex> #{inspect __MODULE__}.translate_subdivision("Cumbria", "en", "bs")
            {:error, {Cldr.UnknownSubdivisionError, "No subdivision translation for :gbcma could be found in locale :bs"}}

            iex> #{inspect __MODULE__}.translate_subdivision("Cumbria", :zzz)
            {:error, {Cldr.InvalidLanguageError, "The language \\"zzz\\" is invalid"}}

            iex> #{inspect __MODULE__}.translate_subdivision("Cumbria", "en", "zzz")
            {:error, {Cldr.InvalidLanguageError, "The language \\"zzz\\" is invalid"}}

        """
        @spec translate_subdivision(String.t(), atom() | String.t() | LanguageTag.t(), atom() | String.t() | LanguageTag.t(), atom()) :: {:ok, String.t()} | {:error, {module(), String.t()}}
        def translate_subdivision(localized_string, from_locale, to_locale \\ Cldr.get_locale(), style \\ :standard)
        def translate_subdivision(localized_string, %LanguageTag{cldr_locale_name: from_locale}, to_locale, style) do
          translate_subdivision(localized_string, from_locale, to_locale, style)
        end
        def translate_subdivision(localized_string, from_locale, %LanguageTag{cldr_locale_name: to_locale}, style) do
          translate_subdivision(localized_string, from_locale, to_locale, style)
        end

        @doc """
        The same as `translate_territory/3`, but raises an exception if it fails.

        ## Example

            iex> #{inspect __MODULE__}.translate_territory!("Reino Unido", "pt")
            "United Kingdom"

            iex> #{inspect __MODULE__}.translate_territory!("United Kingdom", "en", "pt")
            "Reino Unido"

            #=> #{inspect __MODULE__}.translate_territory!("Westworld", "en", "pt")
            ** (Cldr.UnknownTerritoryError) No territory translation for "Westworld" could be found in locale "en"

        """
        @doc since: "2.0.0"
        @spec translate_territory!(String.t(), atom() | String.t() | LanguageTag.t(), atom() | String.t() | LanguageTag.t(), atom()) :: String.t()
        def translate_territory!(localized_string, locale_from, locale_name \\ Cldr.get_locale(), style \\ :standard) do
          case translate_territory(localized_string, locale_from, locale_name, style) do
            {:error, {exception, msg}} -> raise exception, msg

            {:ok, result}              -> result
          end
        end

        @doc """
        The same as `translate_subdivision/3`, but raises an exception if it fails.

        ## Example

            iex> #{inspect __MODULE__}.translate_subdivision!("Cumbria", "en", "pl")
            "Kumbria"

            iex> #{inspect __MODULE__}.translate_subdivision!("Kumbria", "pl", "en")
            "Cumbria"

        """
        @spec translate_subdivision!(String.t(), atom() | String.t() | LanguageTag.t(), atom() | String.t() | LanguageTag.t(), atom()) :: String.t()
        def translate_subdivision!(localized_string, from_locale, to_locale \\ Cldr.get_locale(), style \\ :standard) do
          case translate_subdivision(localized_string, from_locale, to_locale, style) do
            {:error, {exception, msg}} -> raise exception, msg

            {:ok, result}              -> result
          end
        end

        @doc """
        Translate a LanguageTag.t into a localized string from one locale to another.
        Returns `{:ok, result}` if successful, otherwise `{:error, reason}`.

        * `options` are:
          * `locale` is any configured locale. See `#{inspect backend}.known_locale_names/0`.
            The default is `Cldr.get_locale/0`

          * `style` is one of those returned by `#{inspect __MODULE__}.available_styles/0`.
            The current styles are `:short`, `:standard` and `:variant`.
            The default is `:standard`

        ## Example

            iex> #{inspect __MODULE__}.translate_language_tag(Cldr.get_locale())
            {:ok, "world"}

            iex> #{inspect __MODULE__}.translate_language_tag(Cldr.get_locale(), [locale: Cldr.Locale.new!("pt", TestBackend.Cldr)])
            {:ok, "Mundo"}

        """
        @doc since: "2.0.0"
        @spec translate_language_tag(LanguageTag.t(), Keyword.t()) :: {:ok, String.t()} | {:error, {module(), String.t()}}
        def translate_language_tag(tag, options \\ [])
        def translate_language_tag(%LanguageTag{} = tag, options) do
          style = Keyword.get(options, :style, :standard)
          case from_language_tag(tag, [style: style]) do
            {:error, reason} -> {:error, reason}

            {:ok, result}    -> translate_territory(result, tag, Keyword.get(options, :locale, Cldr.get_locale()), style)
          end
        end
        def translate_language_tag(tag, _options), do: unknown_language_tag_error(tag)

        @doc """
        The same as `translate_language_tag/2`, but raises an exception if it fails.

        ## Example

            iex> #{inspect __MODULE__}.translate_language_tag!(Cldr.get_locale())
            "world"

            iex> #{inspect __MODULE__}.translate_language_tag!(Cldr.get_locale(), [locale: Cldr.Locale.new!("pt", TestBackend.Cldr)])
            "Mundo"

        """
        @doc since: "2.0.0"
        @spec translate_language_tag!(LanguageTag.t(), Keyword.t()) :: String.t()
        def translate_language_tag!(locale_from, options \\ [])
        def translate_language_tag!(locale_from, options) do
          case translate_language_tag(locale_from, options) do
            {:error, {exception, msg}} -> raise exception, msg

            {:ok, result}              -> result
          end
        end

        @doc """
        Lists parent(s) for the given territory code.
        Returns `{:ok, list}` if successful, otherwise `{:error, reason}`.

        * `options` are:
          * `as: :atom`
          * `as: :binary`
          * `as: :charlist`

        ## Example

            iex> #{inspect __MODULE__}.parent(:GB)
            {:ok, [:"154", :UN]}

            iex> #{inspect __MODULE__}.parent(:ZZZ)
            {:error, {Cldr.UnknownTerritoryError, "The territory :ZZZ is unknown"}}

            iex> #{inspect __MODULE__}.parent(Cldr.get_locale())
            {:error, {Cldr.UnknownChildrenError, "The territory :\\"001\\" has no parent(s)"}}

        """
        @doc since: "2.0.0"
        @spec parent(atom() | String.t() | LanguageTag.t(), Keyword.t()) :: {:ok, atom() | String.t() | charlist()} | {:error, {module(), String.t()}}
        def parent(territory_code, options \\ [as: :atom]), do: Cldr.Territory.parent(territory_code, options)

        @doc """
        The same as `parent/2`, but raises an exception if it fails.

        * `options` are:
          * `as: :atom`
          * `as: :binary`
          * `as: :charlist`

        ## Example

            iex> #{inspect __MODULE__}.parent!(:GB)
            [:"154", :UN]

        """
        @doc since: "2.0.0"
        @spec parent!(atom() | String.t() | LanguageTag.t(), Keyword.t()) :: [atom() | String.t() | charlist()]
        def parent!(territory_code, options \\ [as: :atom]), do: Cldr.Territory.parent!(territory_code, options)

        @doc """
        Lists children(s) for the given territory code.
        Returns `{:ok, list}` if successful, otherwise `{:error, reason}`.

        * `options` are:
          * `as: :atom`
          * `as: :binary`
          * `as: :charlist`

        ## Example

            iex> #{inspect __MODULE__}.children(:EU)
            {:ok,
            [:AT, :BE, :CY, :CZ, :DE, :DK, :EE, :ES, :FI, :FR, :GR, :HR, :HU, :IE,
              :IT, :LT, :LU, :LV, :MT, :NL, :PL, :PT, :SE, :SI, :SK, :BG, :RO]}

            iex> #{inspect __MODULE__}.children(:ZZZ)
            {:error, {Cldr.UnknownTerritoryError, "The territory :ZZZ is unknown"}}

            iex> #{inspect __MODULE__}.children(:GB)
            {:error, {Cldr.UnknownParentError, "The territory :GB has no children"}}

        """
        @doc since: "2.0.0"
        @spec children(atom() | String.t() | LanguageTag.t(), Keyword.t()) :: {:ok, atom() | String.t() | charlist()} | {:error, {module(), String.t()}}
        def children(territory_code, options \\ [as: :atom]), do: Cldr.Territory.children(territory_code, options)


        @doc """
        The same as `children/2`, but raises an exception if it fails.

        * `options` are:
          * `as: :atom`
          * `as: :binary`
          * `as: :charlist`

        ## Example

            iex> #{inspect __MODULE__}.children!(:EU)
            [:AT, :BE, :CY, :CZ, :DE, :DK, :EE, :ES, :FI, :FR, :GR, :HR, :HU, :IE, :IT,
            :LT, :LU, :LV, :MT, :NL, :PL, :PT, :SE, :SI, :SK, :BG, :RO]

        """
        @doc since: "2.0.0"
        @spec children!(atom() | String.t() | LanguageTag.t(), Keyword.t()) :: [atom() | String.t() | charlist()]
        def children!(territory_code, options \\ [as: :atom]), do: Cldr.Territory.children!(territory_code, options)

        @doc """
        Checks relationship between two territories, where the first argument is the `parent` and second the `child`.
        Returns `true` if successful, otherwise `false`.

        ## Example

            iex> #{inspect __MODULE__}.contains?(:EU, :DK)
            true

            iex> #{inspect __MODULE__}.contains?(:DK, :EU)
            false

        """
        @doc since: "2.0.0"
        @spec contains?(atom() | LanguageTag.t(), atom() | LanguageTag.t()) :: boolean()
        def contains?(parent, child), do: Cldr.Territory.contains?(parent, child)

        @doc """
        Maps territory info for the given territory code.
        Returns `{:ok, map}` if successful, otherwise `{:error, reason}`.

        ## Example

            iex> #{inspect __MODULE__}.info(:GB)
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

        """
        @doc since: "2.0.0"
        @spec info(atom() | LanguageTag.t()) :: {:ok, map()} | {:error, {module(), String.t()}}
        def info(territory_code), do: Cldr.Territory.info(territory_code)


        @doc """
        The same as `info/1`, but raises an exception if it fails.

        ## Example

            iex> #{inspect __MODULE__}.info!(:GB)
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
        @doc since: "2.0.0"
        @spec info!(atom() | LanguageTag.t()) :: map()
        def info!(territory_code), do: Cldr.Territory.info!(territory_code)

        # Generate the functions that encapsulate the territory data from CDLR
        @known_locales Cldr.Locale.Loader.known_locale_names(config)

        for locale_name <- @known_locales do
          locale = Cldr.Locale.Loader.get_locale(locale_name, config)
          territories = Map.fetch!(locale, :territories)
          subdivisions = Map.fetch!(locale, :subdivisions)

          # Maps a territory name to a territory code
          # Flattens all variations of the territory name
          # to the same territory code. Note the normalization
          # of the territory name both here and in `translate_territory/4`
          inverted_territories = for {code, names} <- territories, name <- Map.values(names), into: %{}, do: {Cldr.Territory.normalize_name(name), code}

          # Maps a subdivision name to a subdivision code
          # Note the normalization of the subdivision name
          # both here and in `translate_subdivision/3`
          inverted_subdivisions = for {code, name} <- subdivisions, into: %{}, do: {Cldr.Territory.normalize_name(name), code}

          def available_territories(unquote(locale_name)) do
            unquote(Enum.sort(Map.keys(territories)))
          end

          def available_subdivisions(unquote(locale_name)) do
            unquote(Enum.sort(Map.keys(subdivisions)))
          end

          def known_territories(unquote(locale_name)) do
            unquote(Macro.escape(territories))
          end

          def known_subdivisions(unquote(locale_name)) do
            unquote(Macro.escape(subdivisions))
          end

          def inverted_territories(unquote(locale_name)) do
            unquote(Macro.escape(inverted_territories))
          end

          def inverted_subdivisions(unquote(locale_name)) do
            unquote(Macro.escape(inverted_subdivisions))
          end

          @doc false
          def from_territory_code(territory_code, unquote(locale_name) = locale_name, style) do
            case known_territories(locale_name) do
              %{^territory_code => %{^style => string}} -> {:ok, string}
              %{^territory_code => _}                   -> unknown_style_error(style)
              %{}                                       -> unknown_territory_error(territory_code, locale_name, style)
            end
          end

          @doc false
          def from_subdivision_code(subdivision_code, unquote(locale_name) = locale_name, style) do
            subdivisions = known_subdivisions(locale_name)
            subdivision_aliases = subdivision_aliases()
            aliases =  subdivision_aliases[subdivision_code]
            case Elixir.Map.values(Elixir.Map.take(subdivisions, [subdivision_code | Elixir.List.wrap(aliases)])) do
             [subdivision_translation | _] -> {:ok, subdivision_translation}
             _  when is_nil(aliases)       -> unknown_subdivision_error(subdivision_code, locale_name, style)
             [] when is_atom(aliases)      -> from_territory_code(aliases, locale_name, style)
            end
          end
        end

        def translate_territory(localized_string, locale_from, locale_to, style) do
          with {:ok, locale_from} <- unquote(backend).validate_locale(locale_from),
               {:ok, locale_to} <- unquote(backend).validate_locale(locale_to) do
            normalized_name = Cldr.Territory.normalize_name(localized_string)
            case inverted_territories(locale_from.cldr_locale_name) do
                 %{^normalized_name => territory_code} -> from_territory_code(territory_code, locale_to.cldr_locale_name, style)
                 _territories -> unknown_territory_error(localized_string, locale_from.cldr_locale_name, locale_to.cldr_locale_name)
            end
          end
        end

        def translate_subdivision(localized_string, locale_from, locale_to, style) do
          with {:ok, locale_from} <- unquote(backend).validate_locale(locale_from),
               {:ok, locale_to} <- unquote(backend).validate_locale(locale_to) do
            normalized_name = Cldr.Territory.normalize_name(localized_string)
            case inverted_subdivisions(locale_from.cldr_locale_name) do
              %{^normalized_name => subdivision_code} -> from_subdivision_code(subdivision_code, locale_to.cldr_locale_name, style)
              _subdivisions -> unknown_subdivision_error(localized_string, locale_from.cldr_locale_name, locale_to.cldr_locale_name)
            end
          end
        end


        def available_territories(locale) do
          with {:ok, locale} <- unquote(backend).validate_locale(locale) do
            available_territories(locale.cldr_locale_name)
          end
        end

        def known_territories(locale) do
          with {:ok, locale} <- unquote(backend).validate_locale(locale) do
            known_territories(locale.cldr_locale_name)
          end
        end

        def available_subdivisions(locale) do
          with {:ok, locale} <- unquote(backend).validate_locale(locale) do
            available_subdivisions(locale.cldr_locale_name)
          end
        end

        def known_subdivisions(locale) do
          with {:ok, locale} <- unquote(backend).validate_locale(locale) do
            known_subdivisions(locale.cldr_locale_name)
          end
        end

        @doc """
        Unicode flag for the given territory code.
        Returns `{:ok, flag}` if successful, otherwise `{:error, reason}`.

        ## Example

            iex> #{inspect __MODULE__}.to_unicode_flag(:US)
            {:ok, "🇺🇸"}

            iex> #{inspect __MODULE__}.to_unicode_flag(:EZ)
            {:error, {Cldr.UnknownFlagError, "The territory :EZ has no flag"}}

        """
        @doc since: "2.0.0"
        @spec to_unicode_flag(atom() | String.t() | LanguageTag.t()) :: {:ok, String.t()} | {:error, {module(), String.t()}}
        def to_unicode_flag(territory_code), do: Cldr.Territory.to_unicode_flag(territory_code)

        @doc """
        The same as `to_unicode_flag/1`, but raises an exception if it fails.

        ## Example

            iex> #{inspect __MODULE__}.to_unicode_flag!(:US)
            "🇺🇸"

        """
        @doc since: "2.0.0"
        @spec to_unicode_flag!(atom() | String.t() | LanguageTag.t()) :: String.t()
        def to_unicode_flag!(territory_code), do: Cldr.Territory.to_unicode_flag!(territory_code)

        @doc """
        A helper method to get a territory's currency code
        if a territory has multiply currencies then the oldest active currency is returned.
        Returns `{:ok, code}` if successful, otherwise `{:error, reason}`.

        * `options` are:
          * `as: :atom`
          * `as: :binary`
          * `as: :charlist`

        ## Example

            iex> #{inspect __MODULE__}.to_currency_code(:US)
            {:ok, :USD}

            iex> #{inspect __MODULE__}.to_currency_code("cu")
            {:ok, :CUP}

        """
        @doc since: "2.0.0"
        @spec to_currency_code(atom() | String.t() | LanguageTag.t(), Keyword.t()) :: {:ok, atom() | String.t() | charlist()} | {:error, {module(), String.t()}}
        def to_currency_code(territory_code, options \\ [as: :atom]), do: Cldr.Territory.to_currency_code(territory_code, options)

        @doc """
        The same as `to_currency_code/2`, but raises an exception if it fails.

        * `options` are:
          * `as: :atom`
          * `as: :binary`
          * `as: :charlist`

        ## Example

            iex> #{inspect __MODULE__}.to_currency_code!(:US)
            :USD

            iex> #{inspect __MODULE__}.to_currency_code!(:US, as: :charlist)
            'USD'

            iex> #{inspect __MODULE__}.to_currency_code!("PS")
            :ILS

            iex> #{inspect __MODULE__}.to_currency_code!("PS", as: :binary)
            "ILS"

        """
        @doc since: "2.0.0"
        @spec to_currency_code!(atom() | String.t() | LanguageTag.t(), Keyword.t()) :: atom() | String.t() | charlist()
        def to_currency_code!(territory_code, options \\ [as: :atom]), do: Cldr.Territory.to_currency_code!(territory_code, options)


        @doc """
        A helper method to get a territory's currency codes.
        Returns `{:ok, list}` if successful, otherwise `{:error, reason}`.

        * `options` are:
          * `as: :atom`
          * `as: :binary`
          * `as: :charlist`

        ## Example

            iex> #{inspect __MODULE__}.to_currency_codes(:US)
            {:ok, [:USD]}

            iex> #{inspect __MODULE__}.to_currency_codes("cu")
            {:ok, [:CUP, :CUC]}

        """
        @doc since: "2.0.0"
        @spec to_currency_codes(atom() | String.t() | LanguageTag.t(), Keyword.t()) :: {:ok, [atom() | String.t() | charlist()]} | {:error, {module(), String.t()}}
        def to_currency_codes(territory_code, options \\ [as: :atom]), do: Cldr.Territory.to_currency_codes(territory_code, options)

        @doc """
        The same as `to_currency_codes/2`, but raises an exception if it fails.

        * `options` are:
          * `as: :atom`
          * `as: :binary`
          * `as: :charlist`

        ## Example

            iex> #{inspect __MODULE__}.to_currency_codes!(:US)
            [:USD]

            iex> #{inspect __MODULE__}.to_currency_codes!(:US, as: :charlist)
            ['USD']

            iex> #{inspect __MODULE__}.to_currency_codes!("PS")
            [:ILS, :JOD]

            iex> #{inspect __MODULE__}.to_currency_codes!("PS", as: :binary)
            ["ILS", "JOD"]

        """
        @doc since: "2.0.0"
        @spec to_currency_codes!(atom() | String.t() | LanguageTag.t(), Keyword.t()) :: [atom() | String.t() | charlist()]
        def to_currency_codes!(territory_code, options \\ [as: :atom]), do: Cldr.Territory.to_currency_codes!(territory_code, options)

        @doc """
        Returns a list of country codes.

        * `options` are:
          * `as: :atom`
          * `as: :binary`
          * `as: :charlist`

        ## Example

            => #{inspect __MODULE__}.country_codes()
            [:AD, :AE, :AF, :AG, :AI, :AL, :AM, :AO, :AR, :AS, :AT, :AU, :AW,
            :AX, :AZ, :BA, :BB, :BD, :BE, :BF, :BG, :BH, :BI, :BJ, :BL, :BM,
            :BN, :BO, :BQ, :BR, :BS, :BT, :BV, :BW, :BY, :BZ, :CA, :CC, :CD,
            :CF, :CG, :CH, :CI, :CK, :CL, :CM, :CN, :CO, :CR, :CU, ...]

        """
        @doc since: "2.0.0"
        @spec country_codes(Keyword.t()) :: [atom() | String.t() | charlist()]
        def country_codes(options \\ [as: :atom]), do: Cldr.Territory.country_codes(options)

        defp unknown_territory_error(string, from, _to) do
          {:error, {Cldr.UnknownTerritoryError, "No territory translation for #{inspect string} could be found in locale #{inspect from}"}}
        end

        defp unknown_subdivision_error(string, from, _to) do
          {:error, {Cldr.UnknownSubdivisionError, "No subdivision translation for #{inspect string} could be found in locale #{inspect from}"}}
        end

        defp unknown_style_error(style) do
          {:error, {Cldr.UnknownStyleError, "The style #{inspect style} is unknown"}}
        end

        defp unknown_language_tag_error(language_tag) do
          {:error, {Cldr.UnknownLanguageTagError, "The tag #{inspect language_tag} is not a valid `LanguageTag.t`"}}
        end
      end
    end
  end
end
