defmodule LayoutOMaticSlide do
  use Scenic.Scene

  import Scenic.Primitives
  alias Scenic.Graph

  @layout_path Application.app_dir(:layout_demo, ["priv", "static", "layout-o-matic.jpg"])
  @layout_hash Scenic.Cache.Support.Hash.file!(@layout_path, :sha)

  @spec init(any, any) :: {:ok, any, {:push, map}}
  def init(%{graph: graph}, opts) do
    [%{styles: %{t: center_translate}}] = Graph.get(graph, :center_group)
    Scenic.Cache.Static.Texture.load(@layout_path, @layout_hash)

    this_graph =
      graph
      |> rect({1080, 860}, fill: {:image, @layout_hash}, id: :layout_logo, t: {0, 0})

    {:ok, %{graph: this_graph, viewport: opts[:viewport]}, push: this_graph}
  end

  def handle_input(
        {:key, {"right", :release, 0}},
        _context,
        %{viewport: vp, graph: graph} = state
      ) do
    this_hidden_graph =
      Graph.modify(graph, :layout_logo, fn t -> update_opts(t, hidden: true) end)

    state = Map.replace!(state, :graph, this_hidden_graph)
    Scenic.ViewPort.set_root(vp, {Home, state})
    {:halt, state}
  end

  def handle_input(
        {:key, {"enter", :release, 0}},
        _context,
        %{viewport: vp, graph: graph} = state
      ) do
    this_hidden_graph =
      Graph.modify(graph, :layout_logo, fn t -> update_opts(t, hidden: true) end)

    state = Map.replace!(state, :graph, this_hidden_graph)
    Scenic.ViewPort.set_root(vp, {Home, state})
    {:halt, state}
  end

  def handle_input({:key, {"left", :release, 0}}, _context, %{viewport: vp, graph: graph} = state) do
    this_hidden_graph =
      Graph.modify(graph, :layout_logo, fn t -> update_opts(t, hidden: true) end)

    state = Map.replace!(state, :graph, this_hidden_graph)
    Scenic.ViewPort.set_root(vp, {SimpleGridSlide, state})
    {:halt, state}
  end

  def handle_input(_input, _, state) do
    {:noreply, state}
  end
end
