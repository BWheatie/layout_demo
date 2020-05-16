defmodule TitleSlide do
  use Scenic.Scene

  import Scenic.Primitives
  alias Scenic.Graph
  alias LayoutOMatic.TextPosition

  @spec init(any, any) :: {:ok, any, {:push, map}}
  def init(%{graph: graph}, opts) do
    [%{styles: %{t: center_translate}}] = Graph.get(graph, :center_group)

    text = "Nobody:\nLiterally No One: \n\n\nMe: Let's Write CSS In Elixir!"
    font_size = 90

    this_graph =
      graph
      |> text(text,
        id: :title_text,
        text_align: :left,
        fill: :black,
        font_size: font_size,
        t: TextPosition.center(text, center_translate, font_size)
      )

    {:ok, %{graph: this_graph, viewport: opts[:viewport]}, push: this_graph}
  end

  def handle_input(
        {:key, {"right", :release, 0}},
        _context,
        %{viewport: vp, graph: graph} = state
      ) do
    this_hidden_graph = Graph.modify(graph, :title_text, fn t -> update_opts(t, hidden: true) end)
    state = Map.replace!(state, :graph, this_hidden_graph)
    Scenic.ViewPort.set_root(vp, {ScenicSlide, state})
    {:halt, state}
  end

  def handle_input({:key, {"left", :release, 0}}, _context, %{viewport: vp, graph: graph} = state) do
    this_hidden_graph = Graph.modify(graph, :title_text, fn t -> update_opts(t, hidden: true) end)
    state = Map.replace!(state, :graph, this_hidden_graph)
    Scenic.ViewPort.set_root(vp, {ThanksSlide, state})
    {:halt, state}
  end

  def handle_input(_input, _, state) do
    {:noreply, state}
  end
end
