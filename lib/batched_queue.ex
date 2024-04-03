defmodule Okasaki.BatchedQueue do
  @moduledoc """
  FIFO queue example from figure 5.2
  """

  alias __MODULE__

  defstruct [:front, :rear]

  def head(queue) do
    case queue do
      %BatchedQueue{front: [head | _rest]} -> head
      _queue -> nil
    end
  end

  def tail(queue) do
    case queue do
      %BatchedQueue{front: [_head | front], rear: rear} ->
        check(%BatchedQueue{front: front, rear: rear})

      _queue ->
        nil
    end
  end

  def snoc(queue, item) do
    queue =
      with nil <- queue do
        %BatchedQueue{front: [], rear: []}
      end

    check(%BatchedQueue{queue | rear: [item | queue.rear]})
  end

  def is_empty(queue) do
    case queue do
      %BatchedQueue{rear: []} -> true
      _queue -> false
    end
  end

  defp check(queue) do
    case queue do
      %BatchedQueue{front: [], rear: rear} ->
        %BatchedQueue{front: Enum.reverse(rear), rear: []}

      queue ->
        queue
    end
  end
end
