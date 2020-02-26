defmodule AboutMeSlide do
  use Scenic.Scene

  import Scenic.Primitives
  alias Scenic.Graph
  alias LayoutOMatic.TextPosition

  @spec init(any, any) :: {:ok, any, {:push, map}}
  def init(%{graph: graph}, opts) do
    [%{styles: %{t: top_center_translate}}] = Graph.get(graph, :top_center_group)
    [%{styles: %{t: bottom_center_translate}}] = Graph.get(graph, :bottom_center_group)

    title_text = "Ben Wheat"
    title_font_size = 100
    handles_font_size = 75
    twitter_text = "beardywheat"
    github_text = "BWheatie"
    slack_text = "beardywheat"

    {twitter_x, twitter_y} =
      twitter_text_t =
      TextPosition.center(twitter_text, bottom_center_translate, handles_font_size)

    this_graph =
      graph
      |> text(title_text,
        id: :about_me_title_text,
        fill: :black,
        font_size: title_font_size,
        t: TextPosition.center(title_text, top_center_translate, title_font_size)
      )
      |> add_specs_to_graph(CustomComponents.twitter_handle(twitter_text, twitter_text_t))
      |> add_specs_to_graph(
        CustomComponents.github_handle(github_text, {twitter_x, twitter_y + 100})
      )
      |> add_specs_to_graph(
        CustomComponents.slack_handle(slack_text, {twitter_x, twitter_y + 200})
      )

    {:ok, %{graph: this_graph, viewport: opts[:viewport]}, push: this_graph}
  end

  def handle_input(
        {:key, {"right", :release, 0}},
        _context,
        %{viewport: vp, graph: graph} = state
      ) do
    this_hidden_graph =
      graph
      |> Graph.modify(:about_me_title_text, fn t -> update_opts(t, hidden: true) end)
      |> Graph.modify(:twitter_logo, fn t -> update_opts(t, hidden: true) end)
      |> Graph.modify(:twitter_handle, fn t -> update_opts(t, hidden: true) end)
      |> Graph.modify(:github_logo, fn t -> update_opts(t, hidden: true) end)
      |> Graph.modify(:github_handle, fn t -> update_opts(t, hidden: true) end)
      |> Graph.modify(:slack_logo, fn t -> update_opts(t, hidden: true) end)
      |> Graph.modify(:slack_handle, fn t -> update_opts(t, hidden: true) end)

    state = Map.replace!(state, :graph, this_hidden_graph)
    Scenic.ViewPort.set_root(vp, {ThanksSlide, state})
    {:halt, state}
  end

  def handle_input(
        {:key, {"enter", :release, 0}},
        _context,
        %{viewport: vp, graph: graph} = state
      ) do
    this_hidden_graph =
      graph
      |> Graph.modify(:about_me_title_text, fn t -> update_opts(t, hidden: true) end)
      |> Graph.modify(:twitter_logo, fn t -> update_opts(t, hidden: true) end)
      |> Graph.modify(:twitter_handle, fn t -> update_opts(t, hidden: true) end)
      |> Graph.modify(:github_logo, fn t -> update_opts(t, hidden: true) end)
      |> Graph.modify(:github_handle, fn t -> update_opts(t, hidden: true) end)
      |> Graph.modify(:slack_logo, fn t -> update_opts(t, hidden: true) end)
      |> Graph.modify(:slack_handle, fn t -> update_opts(t, hidden: true) end)

    state = Map.replace!(state, :graph, this_hidden_graph)
    Scenic.ViewPort.set_root(vp, {Home, state})
    {:halt, state}
  end

  def handle_input({:key, {"left", :release, 0}}, _context, %{viewport: vp, graph: graph} = state) do
    this_hidden_graph =
      graph
      |> Graph.modify(:about_me_title_text, fn t -> update_opts(t, hidden: true) end)
      |> Graph.modify(:twitter_logo, fn t -> update_opts(t, hidden: true) end)
      |> Graph.modify(:twitter_handle, fn t -> update_opts(t, hidden: true) end)
      |> Graph.modify(:github_logo, fn t -> update_opts(t, hidden: true) end)
      |> Graph.modify(:github_handle, fn t -> update_opts(t, hidden: true) end)
      |> Graph.modify(:slack_logo, fn t -> update_opts(t, hidden: true) end)
      |> Graph.modify(:slack_handle, fn t -> update_opts(t, hidden: true) end)

    state = Map.replace!(state, :graph, this_hidden_graph)
    Scenic.ViewPort.set_root(vp, {TitleSlide, state})
    {:halt, state}
  end

  def handle_input(_input, _, state) do
    {:noreply, state}
  end
end
