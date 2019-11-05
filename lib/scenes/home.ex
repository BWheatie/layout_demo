defmodule LayoutDemo.Scene.Home do
  use Scenic.Scene

  alias Scenic.Graph
  alias LayoutOMatic.Layouts.{Components.AutoLayout, Grid}

  @viewport Application.get_env(:layout_demo, :viewport)
            |> Map.get(:size)

  @grid %{
    grid_template: [{:equal, 2}],
    max_xy: @viewport,
    grid_ids: [:left, :right],
    starting_xy: {0, 0},
    opts: [draw: true]
  }

  @graph Graph.build()
         |> Scenic.Primitives.add_specs_to_graph(Grid.grid(@grid),
           id: :root_grid
         )

  def init(_, opts) do
    id_list = [
      :this_button,
      :that_button,
      :other_button,
      :another_button
    ]

    graph =
      Enum.reduce(id_list, @graph, fn id, graph ->
        graph
        |> Scenic.Components.button("Button", id: id, styles: %{width: 200, height: 40})
      end)

    {:ok, new_graph} = AutoLayout.auto_layout(graph, :left_group, id_list)
    {:ok, opts, push: new_graph}
  end
end
