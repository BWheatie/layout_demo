defmodule SimpleGridSlide do
  use Scenic.Scene

  import Scenic.Primitives
  alias Scenic.Graph
  alias Scenic.ViewPort
  alias LayoutOMatic.TextPosition
  alias LayoutOMatic.Grid

  @spec init(any, any) :: {:ok, any, {:push, map}}
  def init(%{graph: graph}, opts) do
    [%{styles: %{t: center_translate}}] = Graph.get(graph, :center_group)

    text = "Simple Grid"
    font_size = 75

    this_graph =
      graph
      |> text(text,
        id: :simple_grid_title_text,
        fill: :black,
        font_size: font_size,
        t: TextPosition.center(text, center_translate, font_size)
      )

    {:ok, %{graph: this_graph, viewport: opts[:viewport]}, push: this_graph}
  end

  def handle_input(
        {:key, {"G", :release, 0}},
        _context,
        %{graph: graph, viewport: vp} = state
      ) do
    {:ok, %ViewPort.Status{size: vp_size}} = ViewPort.info(vp)

    this_graph =
      graph
      |> Graph.modify(:simple_grid_title_text, fn t -> update_opts(t, hidden: true) end)
      |> add_specs_to_graph(
        Grid.simple(
          {0, 0},
          vp_size,
          [
            :simple_grid,
            :simple_grid,
            :simple_grid,
            :simple_grid,
            :simple_grid
          ],
          draw: true
        )
      )

    state = Map.replace!(state, :graph, this_graph)
    {:noreply, state, push: this_graph}
  end

  def handle_input(
        {:key, {"right", :release, 0}},
        _context,
        %{viewport: vp, graph: graph} = state
      ) do
    this_hidden_graph =
      graph
      |> Graph.modify(:simple_grid_title_text, fn t -> update_opts(t, hidden: true) end)
      |> Graph.modify(:simple_grid, fn t -> update_opts(t, hidden: true) end)

    state = Map.replace!(state, :graph, this_hidden_graph)
    Scenic.ViewPort.set_root(vp, {LayoutOMaticSlide, state})
    {:halt, state}
  end

  def handle_input(
        {:key, {"enter", :release, 0}},
        _context,
        %{viewport: vp, graph: graph} = state
      ) do
    this_hidden_graph =
      graph
      |> Graph.modify(:simple_grid_title_text, fn t -> update_opts(t, hidden: true) end)
      |> Graph.modify(:simple_grid, fn t -> update_opts(t, hidden: true) end)

    state = Map.replace!(state, :graph, this_hidden_graph)
    Scenic.ViewPort.set_root(vp, {HomeSlide, state})
    {:halt, state}
  end

  def handle_input({:key, {"left", :release, 0}}, _context, %{viewport: vp, graph: graph} = state) do
    this_hidden_graph =
      graph
      |> Graph.modify(:simple_grid_title_text, fn t -> update_opts(t, hidden: true) end)
      |> Graph.modify(:simple_grid, fn t -> update_opts(t, hidden: true) end)

    state = Map.replace!(state, :graph, this_hidden_graph)
    Scenic.ViewPort.set_root(vp, {ThanksSlide, state})
    {:halt, state}
  end

  def handle_input(_input, _, state) do
    {:noreply, state}
  end
end
