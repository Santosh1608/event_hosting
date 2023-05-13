defmodule EventWeb.EventJSON do
  def event(%{result: event}) do
    event
  end

  def show(%{result: events}) do
    events
  end
end
