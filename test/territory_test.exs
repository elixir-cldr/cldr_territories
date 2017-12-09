defmodule Cldr.TerritoryTest do
  use ExUnit.Case
  require Cldr
  alias Cldr.Territory

  doctest Cldr.Territory

  @available_territories [:"001", :"002", :"003", :"005", :"009", :"011", :"013", :"014", :"015", :"017", :"018", :"019", :"021", :"029", :"030", :"034",
                          :"035", :"039", :"053", :"054", :"057", :"061", :"142", :"143", :"145", :"150", :"151", :"154", :"155", :"202", :"419", :AC,
                          :AD, :AE, :AF, :AG, :AI, :AL, :AM, :AO, :AQ, :AR, :AS, :AT, :AU, :AW, :AX, :AZ, :BA, :BB, :BD, :BE, :BF, :BG, :BH, :BI, :BJ,
                          :BL, :BM, :BN, :BO, :BQ, :BR, :BS, :BT, :BV, :BW, :BY, :BZ, :CA, :CC, :CD, :CF, :CG, :CH, :CI, :CK, :CL, :CM, :CN, :CO, :CP,
                          :CR, :CU, :CV, :CW, :CX, :CY, :CZ, :DE, :DG, :DJ, :DK, :DM, :DO, :DZ, :EA, :EC, :EE, :EG, :EH, :ER, :ES, :ET, :EU, :EZ, :FI,
                          :FJ, :FK, :FM, :FO, :FR, :GA, :GB, :GD, :GE, :GF, :GG, :GH, :GI, :GL, :GM, :GN, :GP, :GQ, :GR, :GS, :GT, :GU, :GW, :GY, :HK,
                          :HM, :HN, :HR, :HT, :HU, :IC, :ID, :IE, :IL, :IM, :IN, :IO, :IQ, :IR, :IS, :IT, :JE, :JM, :JO, :JP, :KE, :KG, :KH, :KI, :KM,
                          :KN, :KP, :KR, :KW, :KY, :KZ, :LA, :LB, :LC, :LI, :LK, :LR, :LS, :LT, :LU, :LV, :LY, :MA, :MC, :MD, :ME, :MF, :MG, :MH, :MK,
                          :ML, :MM, :MN, :MO, :MP, :MQ, :MR, :MS, :MT, :MU, :MV, :MW, :MX, :MY, :MZ, :NA, :NC, :NE, :NF, :NG, :NI, :NL, :NO, :NP, :NR,
                          :NU, :NZ, :OM, :PA, :PE, :PF, :PG, :PH, :PK, :PL, :PM, :PN, :PR, :PS, :PT, :PW, :PY, :QA, :QO, :RE, :RO, :RS, :RU, :RW, :SA,
                          :SB, :SC, :SD, :SE, :SG, :SH, :SI, :SJ, :SK, :SL, :SM, :SN, :SO, :SR, :SS, :ST, :SV, :SX, :SY, :SZ, :TA, :TC, :TD, :TF, :TG,
                          :TH, :TJ, :TK, :TL, :TM, :TN, :TO, :TR, :TT, :TV, :TW, :TZ, :UA, :UG, :UM, :UN, :US, :UY, :UZ, :VA, :VC, :VE, :VG, :VI, :VN,
                          :VU, :WF, :WS, :XK, :YE, :YT, :ZA, :ZM, :ZW, :ZZ]

 @info %{currency: [USD: %{from: ~D[1792-01-01]}, USS: %{tender: false, to: ~D[2014-03-01]}, USN: %{tender: false}],
              gdp: 18560000000000, language_population: %{"cho" => %{population_percent: 0.0033},
                                                          "chr" => %{population_percent: 0.0077, writing_percent: 5},
                                                          "dak" => %{population_percent: 0.0059},
                                                          "de" => %{population_percent: 0.47},
                                                          "en" => %{official_status: "de_facto_official", population_percent: 96},
                                                          "es" => %{official_status: "official_regional", population_percent: 9.6},
                                                          "esu" => %{population_percent: 0.0062},
                                                          "fil" => %{population_percent: 0.42},
                                                          "fr" => %{population_percent: 0.56},
                                                          "frc" => %{population_percent: 0.0084},
                                                          "haw" => %{official_status: "official_regional", population_percent: 0.0089},
                                                          "ik" => %{population_percent: 0.0024, writing_percent: 5},
                                                          "it" => %{population_percent: 0.34},
                                                          "ko" => %{population_percent: 0.3},
                                                          "lkt" => %{population_percent: 0.0025},
                                                          "mus" => %{population_percent: 0.0012},
                                                          "nv" => %{population_percent: 0.05},
                                                          "pdc" => %{population_percent: 0.039},
                                                          "ru" => %{population_percent: 0.24},
                                                          "vi" => %{population_percent: 0.34},
                                                          "yi" => %{population_percent: 0.049},
                                                          "zh-Hant" => %{population_percent: 0.69}}, literacy_percent: 99,
               measurement_system: "US", paper_size: "US-Letter", population: 326626000,
               telephone_country_code: 1, temperature_measurement: "metric"}

  @eu [:AT, :BE, :CY, :CZ, :DE, :DK, :EE, :ES, :FI, :FR, :GB, :GR, :HR, :HU, :IE, :IT,
       :LT, :LU, :LV, :MT, :NL, :PL, :PT, :SE, :SI, :SK, :BG, :RO]

  @parants [:"154", :EU, :UN]

  @us Cldr.Locale.new!("en")

  @bs Cldr.Locale.new!("BS")

  test "available_styles/0" do
    assert [:short, :standard, :variant] == Territory.available_styles
  end

  describe "available_territories/1" do
    test "with valid params" do
      assert @available_territories == Territory.available_territories
    end

    test "with invalid params" do
      assert {:error, {Cldr.UnknownLocaleError, "The locale \"zzz\" is not known."}} == Territory.available_territories("zzz")
    end
  end

  describe "from_territory_code/1" do
    test "with valid params" do
      assert {:ok, "United States"} == Territory.from_territory_code(:US)
      assert {:ok, "United States"} == Territory.from_territory_code("us")
      assert {:ok, "US"} == Territory.from_territory_code(:US, [style: :short])
      assert {:ok, "US"} == Territory.from_territory_code("US", [style: :short])
      assert {:ok, "Sjedinjene Američke Države"} == Territory.from_territory_code(:US, [locale: "bs"])
      assert {:ok, "SAD"} == Territory.from_territory_code(:US, [locale: "bs", style: :short])
    end

    test "with invalid params" do
      assert {:error, {Cldr.UnknownTerritoryError, "The territory :ZZ is unknown"}} == Territory.from_territory_code(:ZZ)
      assert {:error, {Cldr.UnknownLocaleError, "The locale \"zzz\" is not known."}} == Territory.from_territory_code(:US, [locale: "zzz", style: :short])
      assert {:error, {Cldr.UnknownLocaleError, "The locale :zzz is not known."}} == Territory.from_territory_code(:US, [locale: :zzz, style: :short])
      assert {:error, {Cldr.UnknownStyleError, "The style \"zzz\" is unknown"}} == Territory.from_territory_code(:US, [locale: "en", style: "zzz"])
      assert {:error, {Cldr.UnknownStyleError, "The style :zzz is unknown"}} == Territory.from_territory_code(:US, [locale: "en", style: :zzz])
    end
  end

  describe "from_territory_code!/1" do
    test "with valid params" do
      assert "United States" == Territory.from_territory_code!(:US)
      assert "United States" == Territory.from_territory_code!("US")
      assert "US" == Territory.from_territory_code!(:US, [style: :short])
      assert "US" == Territory.from_territory_code!("us", [style: :short])
      assert "Sjedinjene Američke Države" == Territory.from_territory_code!(:US, [locale: "bs"])
      assert "SAD" == Territory.from_territory_code!(:US, [locale: "bs", style: :short])
    end

    test "with invalid params" do
      assert_raise Cldr.UnknownTerritoryError, "The territory :ZZ is unknown", fn ->
        Territory.from_territory_code!(:ZZ)
      end
      assert_raise Cldr.UnknownTerritoryError, "The territory \"yy\" is unknown", fn ->
        Territory.from_territory_code!("yy")
      end
      assert_raise Cldr.UnknownLocaleError, "The locale \"zzz\" is not known.", fn ->
        Territory.from_territory_code!(:US, [locale: "zzz", style: :short])
      end
      assert_raise Cldr.UnknownLocaleError, "The locale :zzz is not known.", fn ->
        Territory.from_territory_code!(:US, [locale: :zzz, style: :short])
      end
      assert_raise Cldr.UnknownStyleError, "The style \"zzz\" is unknown", fn ->
        Territory.from_territory_code!(:US, [locale: "en", style: "zzz"])
      end
      assert_raise Cldr.UnknownStyleError, "The style :zzz is unknown", fn ->
        Territory.from_territory_code!(:US, [locale: "en", style: :zzz])
      end
    end
  end

  describe "from_language_tag/1" do
    test "with valid params" do
      assert {:ok, "United States"} == Territory.from_language_tag(@us)
      assert {:ok, "US"} == Territory.from_language_tag(@us, [style: :short])
      assert {:ok, "Bosna i Hercegovina"} == Territory.from_language_tag(@bs)
    end

    test "with invalid params" do
      assert {:error, {Cldr.UnknownLanguageTagError, "The tag :ZZ is not a valid `LanguageTag.t`"}} == Territory.from_language_tag(:ZZ)
      assert {:error, {Cldr.UnknownLanguageTagError, "The tag \"zzz\" is not a valid `LanguageTag.t`"}} == Territory.from_language_tag("zzz", [style: :short])
      assert {:error, {Cldr.UnknownLanguageTagError, "The tag :zzz is not a valid `LanguageTag.t`"}} == Territory.from_language_tag(:zzz, [style: :short])
      assert {:error, {Cldr.UnknownStyleError, "The style \"zzz\" is unknown"}} == Territory.from_territory_code(@bs, [style: "zzz"])
      assert {:error, {Cldr.UnknownStyleError, "The style :zzz is unknown"}} == Territory.from_territory_code(@us, [style: :zzz])
    end
  end

  describe "from_language_tag!/1" do
    test "with valid params" do
      assert "United States" == Territory.from_language_tag!(@us)
      assert "US" == Territory.from_language_tag!(@us, [style: :short])
      assert "Bosna i Hercegovina" == Territory.from_language_tag!(@bs)
    end

    test "with invalid params" do
      assert_raise Cldr.UnknownLanguageTagError, "The tag :ZZ is not a valid `LanguageTag.t`", fn ->
        Territory.from_language_tag!(:ZZ)
      end
      assert_raise Cldr.UnknownLanguageTagError, "The tag \"yy\" is not a valid `LanguageTag.t`", fn ->
        Territory.from_language_tag!("yy", [style: :short])
      end
      assert_raise Cldr.UnknownLanguageTagError, "The tag \"zzz\" is not a valid `LanguageTag.t`", fn ->
        Territory.from_language_tag!("zzz", [style: :short])
      end
      assert_raise Cldr.UnknownLanguageTagError, "The tag :zzz is not a valid `LanguageTag.t`", fn ->
        Territory.from_language_tag!(:zzz, [style: :short])
      end
      assert_raise Cldr.UnknownStyleError, "The style \"zzz\" is unknown", fn ->
        Territory.from_territory_code!(@bs, [style: "zzz"])
      end
      assert_raise Cldr.UnknownStyleError, "The style :zzz is unknown", fn ->
        Territory.from_territory_code!(@us, [style: :zzz])
      end
    end
  end

  describe "translate_territory/3" do
    test "with valid params" do
      assert {:ok, "Sjedinjene Američke Države"} == Territory.translate_territory("United States", "en-001", "bs")
      assert {:ok, "SAD"} == Territory.translate_territory("US", "en-001", "bs")
      assert {:ok, "United States"} == Territory.translate_territory("Sjedinjene Američke Države", "bs", "en-001")
      assert {:ok, "US"} == Territory.translate_territory("SAD", "bs", "en-001")
    end

    test "with invalid params" do
      assert {:error, {Cldr.UnknownLocaleError, "The locale \"zzz\" is not known."}} == Territory.translate_territory("US", "zzz", "bs")
      assert {:error, {Cldr.UnknownLocaleError, "The locale \"zzz\" is not known."}} == Territory.translate_territory("US", "en-001", "zzz")
      assert {:error, {Cldr.UnknownLocaleError, "The locale :zzz is not known."}} == Territory.translate_territory("US", :zzz, "bs")
      assert {:error, {Cldr.UnknownLocaleError, "The locale :zzz is not known."}} == Territory.translate_territory("US", "en-001", :zzz)
    end
  end

  describe "translate_territory!/3" do
    test "with valid params" do
      assert "Sjedinjene Američke Države" == Territory.translate_territory!("United States", "en-001", "bs")
      assert "SAD" == Territory.translate_territory!("US", "en-001", "bs")
      assert "United States" == Territory.translate_territory!("Sjedinjene Američke Države", "bs", "en-001")
      assert "US" == Territory.translate_territory!("SAD", "bs", "en-001")
    end

    test "with invalid params" do
      assert_raise Cldr.UnknownLocaleError, "The locale \"zzz\" is not known.", fn ->
        Territory.translate_territory!("US", "zzz", "bs")
      end
      assert_raise Cldr.UnknownLocaleError, "The locale \"zzz\" is not known.", fn ->
        Territory.translate_territory!("US", "en-001", "zzz")
      end
      assert_raise Cldr.UnknownLocaleError, "The locale :zzz is not known.", fn ->
        Territory.translate_territory!("US", :zzz, "bs")
      end
      assert_raise Cldr.UnknownLocaleError, "The locale :zzz is not known.", fn ->
        Territory.translate_territory!("US", "en-001", :zzz)
      end
    end
  end

  describe "translate_language_tag/2" do
    test "with valid params" do
      assert {:ok, "Sjedinjene Američke Države"} == Territory.translate_language_tag(@us, locale: @bs)
      assert {:ok, "SAD"} == Territory.translate_language_tag(@us, [locale: @bs, style: :short])
      assert {:ok, "United States"} == Territory.translate_language_tag(@us)
      assert {:ok, "US"} == Territory.translate_language_tag(@us, [style: :short])
    end

    test "with invalid params" do
      assert {:error, {Cldr.UnknownLanguageTagError, "The tag \"zzz\" is not a valid `LanguageTag.t`"}} == Territory.translate_language_tag(@us, locale: "zzz")
      assert {:error, {Cldr.UnknownLanguageTagError, "The tag \"US\" is not a valid `LanguageTag.t`"}} == Territory.translate_language_tag("US", locale: @bs)
      assert {:error, {Cldr.UnknownStyleError, "The style \"zzz\" is unknown"}} == Territory.translate_language_tag(@bs, [locale: @us, style: "zzz"])
      assert {:error, {Cldr.UnknownStyleError, "The style :zzz is unknown"}} == Territory.translate_language_tag(@us, [locale: @bs, style: :zzz])
    end
  end

  describe "translate_language_tag!/2" do
    test "with valid params" do
      assert "Sjedinjene Američke Države" == Territory.translate_language_tag!(@us, locale: @bs)
      assert "SAD" == Territory.translate_language_tag!(@us, [locale: @bs, style: :short])
      assert "United States" == Territory.translate_language_tag!(@us)
      assert "US" == Territory.translate_language_tag!(@us, [style: :short])
    end

    test "with invalid params" do
      assert_raise Cldr.UnknownLanguageTagError, "The tag \"zzz\" is not a valid `LanguageTag.t`", fn ->
        Territory.translate_language_tag!(@us, locale: "zzz")
      end
      assert_raise Cldr.UnknownLanguageTagError,"The tag \"US\" is not a valid `LanguageTag.t`", fn ->
        Territory.translate_language_tag!("US", locale: @bs)
      end
      assert_raise Cldr.UnknownStyleError, "The style \"zzz\" is unknown", fn ->
        Territory.translate_language_tag!(@bs, [locale: @us, style: "zzz"])
      end
      assert_raise Cldr.UnknownStyleError, "The style :zzz is unknown", fn ->
        Territory.translate_language_tag!(@us, [locale: @bs, style: :zzz])
      end
    end
  end

  describe "parent/2" do
    test "with valid params" do
      assert {:ok, [:"155", :EU, :EZ, :UN]} == Territory.parent(:FR)
      assert {:ok, @parants} == Territory.parent("dk")
    end

    test "with invalid params" do
      assert {:error, {Cldr.UnknownTerritoryError, "The territory :ZZ is unknown"}} == Territory.parent(:ZZ)
      assert {:error, {Cldr.UnknownTerritoryError, "The territory :dk is unknown"}} == Territory.parent(:dk)
      assert {:error, {Cldr.UnknownChildrenError, "The territory :\"001\" has no parent(s)"}} == Territory.parent(:"001")
    end
  end

  describe "parent!/2" do
    test "with valid params" do
      assert @parants == Territory.parent!(:DK)
      assert @parants == Territory.parent!("gb")
    end

    test "with invalid params" do
      assert_raise Cldr.UnknownTerritoryError, "The territory :ZZ is unknown", fn ->
        Territory.parent!(:ZZ)
      end
      assert_raise Cldr.UnknownTerritoryError, "The territory :dk is unknown", fn ->
        Territory.parent!(:dk)
      end
      assert_raise Cldr.UnknownChildrenError,  "The territory :\"001\" has no parent(s)", fn ->
        Territory.parent!(:"001")
      end
    end
  end

  describe "children/2" do
    test "with valid params" do
      assert {:ok, @eu} == Territory.children(:EU)
    end

    test "with invalid params" do
      assert {:error, {Cldr.UnknownTerritoryError, "The territory :ZZ is unknown"}} == Territory.children(:ZZ)
      assert {:error, {Cldr.UnknownTerritoryError, "The territory :eu is unknown"}} == Territory.children(:eu)
      assert {:error, {Cldr.UnknownParentError, "The territory :DK has no children"}} == Territory.children("dk")
    end
  end

  describe "children!/2" do
    test "with valid params" do
      assert @eu == Territory.children!(:EU)
    end

    test "with invalid params" do
      assert_raise Cldr.UnknownTerritoryError, "The territory :ZZ is unknown", fn ->
        Territory.children!(:ZZ)
      end
      assert_raise Cldr.UnknownTerritoryError, "The territory :eu is unknown", fn ->
        Territory.children!(:eu)
      end
      assert_raise Cldr.UnknownParentError, "The territory :DK has no children", fn ->
        Territory.children!("dk")
      end
    end
  end

  describe "contains?/2" do
    test "with valid params" do
      assert true == Cldr.Territory.contains?(:EU, :DK)
    end

    test "with invalid params" do
      assert false == Cldr.Territory.contains?(:DK, :EU)
      assert false == Cldr.Territory.contains?(:dk, :EU)
      assert false == Cldr.Territory.contains?(:DK, :eu)
    end
  end

  describe "info/1" do
    test "with valid params" do
      assert {:ok, @info} == Territory.info(:US)
      assert {:ok, @info} == Territory.info("us")
      assert {:ok, @info} == Territory.info("US")
    end

    test "with invalid params" do
      assert {:error, {Cldr.UnknownTerritoryError, "The territory :ZZ is unknown"}} == Territory.info("ZZ")
      assert {:error, {Cldr.UnknownTerritoryError, "The territory :ZZ is unknown"}} == Territory.info("zz")
      assert {:error, {Cldr.UnknownTerritoryError, "The territory :us is unknown"}} == Territory.info(:us)
      assert {:error, {Cldr.UnknownTerritoryError, "The territory :ZZ is unknown"}} == Territory.info(:ZZ)
      assert {:error, {Cldr.UnknownTerritoryError, "The territory :zz is unknown"}} == Territory.info(:zz)
    end
  end

  describe "info!/1" do
    test "with valid params" do
      assert @info == Cldr.Territory.info!(:US)
      assert @info == Cldr.Territory.info!("us")
      assert @info == Cldr.Territory.info!("US")
    end

    test "with invalid params" do
      assert_raise Cldr.UnknownTerritoryError, "The territory :ZZ is unknown", fn ->
        Territory.info!("ZZ")
      end
      assert_raise Cldr.UnknownTerritoryError, "The territory :ZZ is unknown", fn ->
        Territory.info!("zz")
      end
      assert_raise Cldr.UnknownTerritoryError, "The territory :us is unknown", fn ->
        Territory.info!(:us)
      end
      assert_raise Cldr.UnknownTerritoryError, "The territory :ZZ is unknown", fn ->
        Territory.info!(:ZZ)
      end
      assert_raise Cldr.UnknownTerritoryError, "The territory :zz is unknown", fn ->
        Territory.info!(:zz)
      end
    end
  end

  describe "to_unicode_flag/1" do
    test "with valid params" do
      assert {:ok, "🇺🇸"} == Territory.to_unicode_flag(:US)
      assert {:ok, "🇪🇺"} == Territory.to_unicode_flag(:EU)
    end

    test "with invalid params" do
      assert {:error, {Cldr.UnknownFlagError, "The territory :EZ has no flag"}} == Territory.to_unicode_flag(:EZ)
      assert {:error, {Cldr.UnknownTerritoryError, "The territory :ZZ is unknown"}} == Territory.to_unicode_flag("zz")
      assert {:error, {Cldr.UnknownTerritoryError, "The territory :us is unknown"}} == Territory.to_unicode_flag(:us)
      assert {:error, {Cldr.UnknownTerritoryError, "The territory :ZZ is unknown"}} == Territory.to_unicode_flag(:ZZ)
      assert {:error, {Cldr.UnknownTerritoryError, "The territory :zz is unknown"}} == Territory.to_unicode_flag(:zz)
    end
  end

  describe "to_unicode_flag!/1" do
    test "with valid params" do
      assert "🇺🇸" == Cldr.Territory.to_unicode_flag!(:US)
      assert "🇩🇰" == Cldr.Territory.to_unicode_flag!(:DK)
      assert "🇪🇺" == Cldr.Territory.to_unicode_flag!(:EU)
    end

    test "with invalid params" do
      assert_raise Cldr.UnknownFlagError, "The territory :EZ has no flag", fn ->
        Territory.to_unicode_flag!(:EZ)
      end
      assert_raise Cldr.UnknownTerritoryError, "The territory \"zzzzz\" is unknown", fn ->
        Territory.to_unicode_flag!("zzzzz")
      end
      assert_raise Cldr.UnknownTerritoryError, "The territory :us is unknown", fn ->
        Territory.to_unicode_flag!(:us)
      end
      assert_raise Cldr.UnknownTerritoryError, "The territory :ZZ is unknown", fn ->
        Territory.to_unicode_flag!(:ZZ)
      end
      assert_raise Cldr.UnknownTerritoryError, "The territory :zz is unknown", fn ->
        Territory.to_unicode_flag!(:zz)
      end
    end
  end

end
