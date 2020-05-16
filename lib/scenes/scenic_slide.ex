defmodule ScenicSlide do
  use Scenic.Scene

  import Scenic.Primitives
  import Scenic.Components
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
      |> rect({67, 116},
        fill: {:image, @scenic_parrot_hash},
        t: {elem(top_right_translate, 0) + 100, elem(top_right_translate, 1) - 30},
        id: :scenic_logo
      )

    Scenic.Cache.Static.Texture.load(@scenic_parrot_path, @scenic_parrot_hash)
    {:ok, %{graph: this_graph, viewport: opts[:viewport]}, push: this_graph}
  end

  def handle_input(
        {:key, {"right", :release, 0}},
        _context,
        %{viewport: vp, graph: graph} = state
      ) do
    this_hidden_graph =
      graph
      |> Graph.modify(:scenic_title_text, fn t -> update_opts(t, hidden: true) end)
      |> Graph.modify(:scenic_logo, fn t -> update_opts(t, hidden: true) end)

    state = Map.replace!(state, :graph, this_hidden_graph)
    Scenic.ViewPort.set_root(vp, {CSSSlide, state})
    {:halt, state}
  end

  def handle_input(
        {:key, {"C", :release, 0}},
        _context,
        %{viewport: vp, graph: graph}
      ) do
    this_graph =
      graph
      |> circle(50, stroke: {2, :black}, t: {100, 100})

    {:noreply, %{graph: this_graph, viewport: vp}, push: this_graph}
  end

  def handle_input(
        {:key, {"T", :release, 0}},
        _context,
        %{viewport: vp, graph: graph}
      ) do
    this_graph =
      graph
      |> text("This is text that runs off", fill: :black, t: {1467, 100})

    {:noreply, %{graph: this_graph, viewport: vp}, push: this_graph}
  end

  def handle_input(
        {:key, {"1", :release, 0}},
        _context,
        %{viewport: vp, graph: graph}
      ) do
    this_graph =
      graph
      |> button("This is the first button", t: {500, 300}, id: :scenic_button)

    {:noreply, %{graph: this_graph, viewport: vp}, push: this_graph}
  end

  def handle_input(
        {:key, {"2", :release, 0}},
        _context,
        %{viewport: vp, graph: graph}
      ) do
    this_graph =
      graph
      |> button("This is also a button", width: 200, t: {500, 340}, id: :scenic_button)

    {:noreply, %{graph: this_graph, viewport: vp}, push: this_graph}
  end

  def handle_input(
        {:key, {"3", :release, 0}},
        _context,
        %{viewport: vp, graph: graph}
      ) do
    this_graph =
      graph
      |> button("This is the other button", width: 200, t: {507, 380}, id: :scenic_button)

    {:noreply, %{graph: this_graph, viewport: vp}, push: this_graph}
  end

  def handle_input(
        {:key, {"4", :release, 0}},
        _context,
        %{viewport: vp, graph: graph}
      ) do
    this_graph =
      graph
      |> button("This is the last button", width: 200, t: {500, 420}, id: :scenic_button)

    {:noreply, %{graph: this_graph, viewport: vp}, push: this_graph}
  end

  def handle_input({:key, {"up", :release, 0}}, _context, %{viewport: vp, graph: graph} = state) do
    this_hidden_graph =
      graph
      |> Graph.modify(:scenic_title_text, fn t -> update_opts(t, hidden: true) end)
      |> Graph.modify(:scenic_logo, fn t -> update_opts(t, hidden: true) end)
      |> Graph.modify(:scenic_button, fn t -> update_opts(t, hidden: true) end)

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
      graph
      |> Graph.modify(:scenic_title_text, fn t -> update_opts(t, hidden: true) end)
      |> Graph.modify(:scenic_logo, fn t -> update_opts(t, hidden: true) end)
      |> Graph.modify(:scenic_button, fn t -> update_opts(t, hidden: true) end)

    state = Map.replace!(state, :graph, this_hidden_graph)
    Scenic.ViewPort.set_root(vp, {HomeSlide, state})
    {:halt, state}
  end

  def handle_input({:key, {"left", :release, 0}}, _context, %{viewport: vp, graph: graph} = state) do
    this_hidden_graph =
      graph
      |> Graph.modify(:scenic_title_text, fn t -> update_opts(t, hidden: true) end)
      |> Graph.modify(:scenic_logo, fn t -> update_opts(t, hidden: true) end)
      |> Graph.modify(:scenic_button, fn t -> update_opts(t, hidden: true) end)

    state = Map.replace!(state, :graph, this_hidden_graph)
    Scenic.ViewPort.set_root(vp, {ThanksSlide, state})
    {:halt, state}
  end

  def handle_input(_input, _, state) do
    {:noreply, state}
  end
end
