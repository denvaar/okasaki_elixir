defmodule Okasaki.BatchedQueueTest do
  use ExUnit.Case

  alias Okasaki.BatchedQueue

  doctest Okasaki.BatchedQueue

  test "First in, first out" do
    items = [1, 2, 3, 4, 5]

    queue =
      for n <- items, reduce: nil do
        queue ->
          BatchedQueue.snoc(queue, n)
      end

    for n <- items, reduce: queue do
      queue ->
        assert BatchedQueue.head(queue) == n
        BatchedQueue.tail(queue)
    end
  end
end
