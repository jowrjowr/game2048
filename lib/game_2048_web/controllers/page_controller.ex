defmodule Game2048Web.PageController do
  use Game2048Web, :controller
  alias Game2048.Game

  def move(conn, %{"move" => move }) do

    # the game receives some sort of move.

    game_id = 0
    square_size = 6

    # do some sort of move validation?
    _permitted_move = ["up", "down", "left", "right"]

    # grab the game state from ETS and build it out if it does not exist

    game_state =
      case :ets.lookup(:game, game_id) do
        [] ->
          # fresh start
          # trying a long single list for easier manipulation later

          list_length = trunc(:math.pow(square_size, 2))

          state =
            1..list_length
            |> Enum.to_list()
            |> Enum.map(fn x -> 0 end)

          {:ok, state} = Game.insert_random(state, 2)

          state

        ets_result ->

          # needs a little ... unpacking.
          [{game_id, state}] = ets_result
          state

      end

    # process the move

    {result, game_state} =
      case move do
        "down" -> Game.down(game_state)
      end

    # IO.inspect(move)
    # IO.inspect(data)

    render(conn, "move.json", data: [])

    end
end
