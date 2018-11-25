defmodule TestBackend.Cldr do
  use Cldr,
    default_locale: "en-001",
    locales: ["root", "fr", "zh", "en", "bs", "pl", "ru", "th", "he", "pt", "en-001"]
end
