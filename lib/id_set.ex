defmodule IdSet do
  @moduledoc """
    An IdSet allows you to manage lists containing structs unique by id.
  
    Any struct added/deleted must have an id field.

    It's different from MapSet in that the comparison is not unique by value but unique by an id field.
  """

  @doc """
  Adds a struct to a list uniquely by id.

  Any duplicate items by id in the list are removed.

  Returns an updated list.

  ## Examples

      iex> IdSet.add([], %{id: 1})
      [%{id: 1}]

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
      unique(list)
    end
  end

  @doc """
  Removes any duplicate structs by id from the list

  Returns an updated list.

  ## Examples

      iex> IdSet.unique([%{id: 1}, %{id: 1}])
      [%{id: 1}]

  """
  def unique(list) do
    unique(list, [])
  end

  defp unique([], acc) do
    acc
  end

  defp unique([element | rest], acc) do
    unique(rest, add(acc, element))
  end

  @doc """
  Deletes an item matching the struct.id from the list

  Returns an updated list.

  ## Examples

      iex> IdSet.delete([%{id: 1}, %{id: 2}], %{id: 1})
      [%{id: 2}]

  """

  def delete([], _struct) do
    []
  end

  def delete(list, %{id: id}) do
    Enum.reject(list, fn item -> item.id == id end)
  end

  @doc """
  Checks if the struct exists within the list.

  Returns true or false

  ## Examples

      iex> IdSet.member?([%{id: 1}], %{id: 1})
      true

  """
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
