defmodule ThanksSlide do
  use Scenic.Scene

  import Scenic.Primitives
  alias Scenic.Graph

  @blockfi_path Application.app_dir(:layout_demo, ["priv", "static", "blockfi.png"])
  @blockfi_hash Scenic.Cache.Support.Hash.file!(@blockfi_path, :sha)

  @spec init(any, any) :: {:ok, any, {:push, map}}
  def init(%{graph: graph}, opts) do
    [%{styles: %{t: {center_x, center_y}}}] = Graph.get(graph, :center_group)
    logo_size = {128, 128}

    this_graph =
      graph
      |> rect(logo_size,
        fill: {:image, @blockfi_hash},
        t: {center_x - 64, center_y - 64},
        id: :thanks_blockfi_logo
      )

    Scenic.Cache.Static.Texture.load(@blockfi_path, @blockfi_hash)

    {:ok, %{graph: this_graph, viewport: opts[:viewport]}, push: this_graph}
  end

  def handle_input(
        {:key, {"right", :release, 0}},
        _context,
        %{viewport: vp, graph: graph} = state
      ) do
    this_hidden_graph =
      Graph.modify(graph, :thanks_blockfi_logo, fn t -> update_opts(t, hidden: true) end)

    state = Map.replace!(state, :graph, this_hidden_graph)
    Scenic.ViewPort.set_root(vp, {TitleSlide, state})
    {:halt, state}
  end

  def handle_input(
        {:key, {"enter", :release, 0}},
        _context,
        %{viewport: vp, graph: graph} = state
      ) do
    this_hidden_graph =
      Graph.modify(graph, :thanks_blockfi_logo, fn t -> update_opts(t, hidden: true) end)

    state = Map.replace!(state, :graph, this_hidden_graph)
    Scenic.ViewPort.set_root(vp, {HomeSlide, state})
    {:halt, state}
  end

  def handle_input({:key, {"left", :release, 0}}, _context, %{viewport: vp, graph: graph} = state) do
    this_hidden_graph =
      Graph.modify(graph, :thanks_blockfi_logo, fn t -> update_opts(t, hidden: true) end)

    state = Map.replace!(state, :graph, this_hidden_graph)
    Scenic.ViewPort.set_root(vp, {AboutMeSlide, state})
    {:halt, state}
  end

  def handle_input(_input, _, state) do
    {:noreply, state}
  end
end
