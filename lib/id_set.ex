defmodule IdSet do
  @moduledoc """
  Documentation for `IdSet`.
  """

  def add([], struct) do
    [struct]
  end

  def add(list, nil) do
    unique(list, [])
  end

  def add(list, struct) do
    if !member?(list, struct) do
      [struct | list]
    else
      unique(list, [])
    end
  end

  def unique([], acc) do
    acc
  end

  def unique([element | rest], acc) do
    unique(rest, add(acc, element))
  end

  def delete([], _struct) do
    []
  end

  def delete(list, %{id: id}) do
    Enum.reject(list, fn item -> item.id == id end)
  end

  def member?(list, struct) do
    find(list, struct)
  end

  defp find([%{id: id} | _], %{id: id}) do
    true
  end

  defp find([_ | tail], struct) do
    find(tail, struct)
  end

  defp find([], _struct), do: false
end
