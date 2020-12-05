defmodule Game2048.Game do

  def insert_random(state, value) do

    random = :rand.uniform(length(state) + 1)

    final_state =
      state
      |> List.replace_at(random, value)

    {:ok, final_state}

  end

  def down(initial_state) do
    # move the board down
    # all y coordinates decrement by 1, to a floor of 0.

    length =
      initial_state
      |> length()
      |> :math.sqrt()
      |> trunc()

    # with the transposition, each row is a column which now allows easier
    # compacting for the movement.

    # now i can iterate through each row, and do a compactify operation
    # and reverse the transposition operation to get the proper state.

    result =
      initial_state
      |> Enum.chunk_every(length)
      |> transpose()
      |> Enum.map_every(1, fn x -> pad(compact(x), length) end)
      |> transpose()

     {:ok, result}

  end

  def pad(list, length) do
    # pad out a list to a given length with zeroes

    padding_amount = length - length(list)

    case padding_amount do
      0 ->
        # don't need padding
        list
      _ ->
        # needs some amount of padding

        padding = Enum.map(1..padding_amount, fn _ -> 0 end)
        list ++ padding
    end
  end

  def compact(list) do
    # remove zeroes. they'll be re-padded later.
    list = Enum.filter(list, fn x -> x > 0 end)
    compact([], list)
  end

  def compact([], [result]) do
    # simplest case
    [result]
  end

  def compact(acc, remainder) when length(remainder) >= 3 do

    # the compacting needs to work from head to tail

    # we grab the first and next game squares.
    [head | tail] = remainder
    [next | tail] = tail

    IO.inspect(remainder)
    IO.inspect(tail)

    # here we do the actual compacting. this is going to leave the
    # overall list shorter but we'll pad it later.

    if head == next do
      total = head + next
      compact(acc ++ [total], tail)
    else
      compact(acc ++ [head] ++ [next], tail)
    end

  end

  def compact(acc, remainder) when length(remainder) == 2 do

    [head | [tail]] = remainder

    result =
      if head == tail do
        total = head + tail
        acc ++ [total]
      else
        acc ++ [head] ++ [tail]
      end

    if result == Enum.dedup(result) do
      # we're done!
      result
    else
      # time for another pass!
      compact([], result)
    end

  end

  def compact(acc, remainder) when length(remainder) == 1 do

    {second_to_last, acc} = List.pop_at(acc, -1)
    last = List.last(remainder)

    IO.inspect(second_to_last)
    IO.inspect(last)
    result =
      if second_to_last == last do
        total = second_to_last + last
        acc ++ [total]
      else
        acc ++ [second_to_last] ++ [last]
      end

    if result == Enum.dedup(result) do
      # we're done!
      result
    else
      # time for another pass!
      compact([], result)
    end
  end

  def compact(acc, _remainder) do
    acc
  end

  def reverse_compact(list) do
    # compact in the other direction
    list
      |> Enum.reverse()
      |> compact()
  end

  # https://stackoverflow.com/questions/23705074/is-there-a-transpose-function-in-elixir
  defp transpose([]), do: []
  defp transpose([[]|_]), do: []
  defp transpose(a) do
    [Enum.map(a, &hd/1) | transpose(Enum.map(a, &tl/1))]
  end

end
