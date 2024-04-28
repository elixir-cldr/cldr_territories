defmodule TestBackend.Cldr do
  require Cldr.Territory.Backend

  use Cldr,
    default_locale: "en-001",
    locales: ["fr", "zh", "en", "bs", "pl", "ru", "th", "he", "pt", "en-001", "nl"],
    providers: [Cldr.Territory]
end

defmodule TestAllBackends.Cldr do
  require Cldr.Territory.Backend

  use Cldr,
    default_locale: "en-001",
    locales: ["en-001"],
    providers: [Cldr.Calendar, Cldr.DateTime, Cldr.Language, Cldr.List, Cldr.Message, Cldr.Number, Cldr.Territory, Cldr.Unit]
end
