use Mix.Config

config :ex_cldr,
  default_locale: "en",
  locales: ["root", "en", "pt"],
  gettext: Cldr.Gettext,
  precompile_number_formats: ["¤¤#,##0.##"],
  precompile_transliterations: [{:latn, :arab}, {:arab, :thai}]
