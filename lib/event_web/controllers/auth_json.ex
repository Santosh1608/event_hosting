defmodule EventWeb.AuthJSON do
  def register(%{result: result}) do
    result
  end

  def login(%{result: result}) do
    result
  end

  def me(%{result: result}) do
    result
  end
end
