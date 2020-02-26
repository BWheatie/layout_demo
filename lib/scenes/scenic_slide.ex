defmodule ScenicSlide do
  use Scenic.Scene

  import Scenic.Primitives
  alias Scenic.Graph
  alias LayoutOMatic.TextPosition

  @scenic_parrot_path Application.app_dir(:layout_demo, ["priv", "static", "scenic_parrot.png"])
  @scenic_parrot_hash Scenic.Cache.Support.Hash.file!(@scenic_parrot_path, :sha)

  @spec init(any, any) :: {:ok, any, {:push, map}}
  def init(%{graph: graph}, opts) do
    [%{styles: %{t: center_translate}}] = Graph.get(graph, :center_group)
    [%{data: top_right_translate}] = Graph.get(graph, :top_right)

    text = "Scenic"
    font_size = 75

    this_graph =
      graph
      |> text(text,
        id: :scenic_title_text,
        fill: :black,
        font_size: font_size,
        t: TextPosition.center(text, center_translate, font_size)
      )
      |> rect({67, 116}, fill: {:image, @scenic_parrot_hash}, t: top_right_translate)

    Scenic.Cache.Static.Texture.load(@scenic_parrot_path, @scenic_parrot_hash)
    {:ok, %{graph: this_graph, viewport: opts[:viewport]}, push: this_graph}
  end

  def handle_input(
        {:key, {"right", :release, 0}},
        _context,
        %{viewport: vp, graph: graph} = state
      ) do
    this_hidden_graph =
      Graph.modify(graph, :scenic_title_text, fn t -> update_opts(t, hidden: true) end)

    state = Map.replace!(state, :graph, this_hidden_graph)
    Scenic.ViewPort.set_root(vp, {CSSSlide, state})
    {:halt, state}
  end

  def handle_input({:key, {"up", :release, 0}}, _context, %{viewport: vp, graph: graph} = state) do
    this_hidden_graph =
      Graph.modify(graph, :scenic_title_text, fn t -> update_opts(t, hidden: true) end)

    state = Map.replace!(state, :graph, this_hidden_graph)
    Scenic.ViewPort.set_root(vp, {SimpleGridSlide, state})
    {:halt, state}
  end

  def handle_input(
        {:key, {"enter", :release, 0}},
        _context,
        %{viewport: vp, graph: graph} = state
      ) do
    this_hidden_graph =
      Graph.modify(graph, :scenic_title_text, fn t -> update_opts(t, hidden: true) end)

    state = Map.replace!(state, :graph, this_hidden_graph)
    Scenic.ViewPort.set_root(vp, {Home, state})
    {:halt, state}
  end

  def handle_input({:key, {"left", :release, 0}}, _context, %{viewport: vp, graph: graph} = state) do
    this_hidden_graph =
      Graph.modify(graph, :scenic_title_text, fn t -> update_opts(t, hidden: true) end)

    state = Map.replace!(state, :graph, this_hidden_graph)
    Scenic.ViewPort.set_root(vp, {ThanksSlide, state})
    {:halt, state}
  end

  def handle_input(_input, _, state) do
    {:noreply, state}
  end
end
