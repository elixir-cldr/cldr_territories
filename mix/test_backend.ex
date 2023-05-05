require Cldr.Territory.Backend

defmodule TestBackend.Cldr do
  use Cldr,
    default_locale: "en-001",
    locales: ["fr", "zh", "en", "bs", "pl", "ru", "th", "he", "pt", "en-001", "nl"],
    providers: [Cldr.Territory]
end
