defmodule Okasaki.LeftistHeap do
  @moduledoc """
  """

  alias __MODULE__

  defstruct [:rank, :data, :left_child, :right_child]

  @type t :: %LeftistHeap{rank: non_neg_integer(), data: any(), left_child: t(), right_child: t()}

  @spec insert(t(), any()) :: t()
  def insert(heap, data),
    do: merge(%LeftistHeap{rank: 1, data: data, left_child: nil, right_child: nil}, heap)

  @spec find_min(t() | nil) :: any()
  def find_min(heap) do
    with %LeftistHeap{data: data} <- heap do
      data
    end
  end

  @spec delete_min(t() | nil) :: t() | nil
  def delete_min(heap) do
    case heap do
      nil -> nil
      %LeftistHeap{left_child: a, right_child: b} -> merge(a, b)
    end
  end

  @spec is_empty(t() | nil) :: boolean()
  def is_empty(heap) do
    case heap do
      nil -> true
      _heap -> false
    end
  end

  @spec rank(t() | nil) :: non_neg_integer()
  def rank(heap) do
    case heap do
      nil -> 0
      %LeftistHeap{rank: rank} -> rank
    end
  end

  @spec merge(t() | nil, t() | nil) :: t()
  defp merge(heap_a, heap_b)

  defp merge(heap, nil), do: heap
  defp merge(nil, heap), do: heap

  defp merge(%LeftistHeap{} = heap_a, %LeftistHeap{} = heap_b) do
    if heap_a.data <= heap_b.data do
      make(heap_a.left_child, merge(heap_a.right_child, heap_b), heap_a.data)
    else
      make(heap_b.left_child, merge(heap_a, heap_b.right_child), heap_b.data)
    end
  end

  @spec make(t(), t(), any()) :: t()
  defp make(heap_a, heap_b, data) do
    rank_a = rank(heap_a)
    rank_b = rank(heap_b)

    if rank_a >= rank_b do
      %LeftistHeap{rank: rank_b + 1, data: data, left_child: heap_a, right_child: heap_b}
    else
      %LeftistHeap{rank: rank_a + 1, data: data, left_child: heap_b, right_child: heap_a}
    end
  end
end
