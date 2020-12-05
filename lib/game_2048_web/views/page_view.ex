defmodule Game2048Web.PageView do
  use Game2048Web, :view

  def render("move.json", data) do
    %{
      data: []
    }
   end
end
