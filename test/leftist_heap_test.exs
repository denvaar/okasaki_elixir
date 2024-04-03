defmodule Okasaki.LeftistHeapTest do
  use ExUnit.Case

  alias Okasaki.LeftistHeap

  doctest Okasaki.LeftistHeap

  test "can insert numbers" do
    nil
    |> LeftistHeap.insert(44)
    |> tap(fn heap ->
      assert %LeftistHeap{rank: 1, data: 44, left_child: nil, right_child: nil} = heap
    end)
    |> LeftistHeap.insert(20)
    |> tap(fn heap ->
      assert %LeftistHeap{
               rank: 1,
               data: 20,
               left_child: %Okasaki.LeftistHeap{
                 rank: 1,
                 data: 44,
                 left_child: nil,
                 right_child: nil
               },
               right_child: nil
             } = heap
    end)
  end

  test "a node's rank is the distance to the nearest empty position in the subtree" do
    heap =
      nil
      |> LeftistHeap.insert(8)
      |> LeftistHeap.insert(4)
      |> LeftistHeap.insert(5)
      |> LeftistHeap.insert(6)

    #       [4]     -- rank 2
    #   [5]    [8]  -- rank 1
    #        [6]    -- rank 1

    assert heap.rank == 2
    assert heap.left_child.rank == 1
    assert heap.right_child.rank == 1
    assert heap.right_child.left_child.rank == 1
  end

  test "right child of each node has a lower rank value" do
    heap =
      nil
      |> LeftistHeap.insert(6)
      |> LeftistHeap.insert(8)
      |> LeftistHeap.insert(5)
      |> LeftistHeap.insert(4)
      |> LeftistHeap.insert(9)
      |> LeftistHeap.insert(0)
      |> LeftistHeap.insert(1)
      |> LeftistHeap.insert(2)
      |> LeftistHeap.insert(19)
      |> LeftistHeap.insert(-20)

    for _n <- 1..10, reduce: heap do
      node ->
        assert LeftistHeap.rank(node) >= LeftistHeap.rank(node.right_child)

        LeftistHeap.delete_min(node)
    end
  end

  test "minimum number always comes out first" do
    numbers = [190, 200, 202, 10, 90, 404, 20, 20, 1, 5000]

    heap =
      for n <- numbers, reduce: nil do
        heap -> LeftistHeap.insert(heap, n)
      end

    for n <- Enum.sort(numbers), reduce: heap do
      heap ->
        assert LeftistHeap.find_min(heap) == n
        LeftistHeap.delete_min(heap)
    end
  end
end
