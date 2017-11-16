defmodule Cldr.UnknownStyleError do
  @moduledoc """
  Exception raised when there is an invalid style.
  """

  defexception [:message]

  def exception(message) do
  %__MODULE__{message: message}
  end
end

defmodule Cldr.UnknownChildrenError do
  @moduledoc """
  Exception raised when there is an invalid child.
  """

  defexception [:message]

  def exception(message) do
  %__MODULE__{message: message}
  end
end

defmodule Cldr.UnknownParentError do
  @moduledoc """
  Exception raised when there is an invalid parent.
  """

  defexception [:message]

  def exception(message) do
  %__MODULE__{message: message}
  end
end

defmodule Cldr.UnknownLanguageTagError do
  @moduledoc """
  Exception raised when there is an invalid LanguageTag.t.
  """

  defexception [:message]

  def exception(message) do
  %__MODULE__{message: message}
  end
end

