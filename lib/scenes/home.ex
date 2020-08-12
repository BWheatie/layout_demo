defmodule HomeSlide do
  use Scenic.Scene

  import Scenic.Primitives
  alias Scenic.Graph
  alias Scenic.ViewPort
  alias LayoutOMatic.Grid

  @viewport_size Application.get_env(:layout_demo, :viewport) |> Map.get(:size)
  @font_metrics_path Application.app_dir(:layout_demo, [
                       "priv",
                       "static",
                       "fonts",
                       "Oswald",
                       "Oswald-Regular.ttf.metrics"
                     ])
  @font_hash Scenic.Cache.Support.Hash.file!(@font_metrics_path, :sha)

  @graph Graph.build(clear_color: :white, font: @font_hash)
         |> add_specs_to_graph(
           Grid.simple({0, 0}, @viewport_size, [:top, :right, :bottom, :left, :center]),
           id: :root_grid,
           font: @font_hash
         )

  @spec init(any, any) :: {:ok, any, {:push, map}}
  def init(_, opts) do
    IO.inspect(@graph)
    Scenic.Cache.Static.FontMetrics.load!(@font_metrics_path, @font_hash)
    [%{styles: %{t: top_min}}] = Graph.get(@graph, :top_group)
    [%{data: top_max}] = Graph.get(@graph, :top)
    [%{styles: %{t: bottom_min}}] = Graph.get(@graph, :bottom_group)

    top_grid_ids = [:top_top, :top_bottom, :top_left, :top_right, :top_center]
    bottom_grid_ids = [:bottom_top, :bottom_bottom, :bottom_left, :bottom_right, :bottom_center]

    graph =
      @graph
      |> add_specs_to_graph(
        List.flatten([
          Grid.simple(top_min, top_max, top_grid_ids),
          Grid.simple(bottom_min, @viewport_size, bottom_grid_ids)
        ])
      )

    {:ok, %{graph: graph, viewport: opts[:viewport]}, push: graph}
  end

  def handle_input({:key, {"right", :release, 0}}, _context, %{viewport: vp} = state) do
    ViewPort.set_root(vp, {AboutMeSlide, state})
    {:halt, state}
  end

  def handle_input(_input, _, state) do
    {:noreply, state}
  end
end
