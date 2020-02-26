defmodule CustomComponents do
  import Scenic.Primitives

  @twitter_path Application.app_dir(:layout_demo, ["priv", "static", "twitter.png"])
  @twitter_hash Scenic.Cache.Support.Hash.file!(@twitter_path, :sha)
  @github_path Application.app_dir(:layout_demo, ["priv", "static", "github.png"])
  @github_hash Scenic.Cache.Support.Hash.file!(@github_path, :sha)
  @slack_path Application.app_dir(:layout_demo, ["priv", "static", "slack.png"])
  @slack_hash Scenic.Cache.Support.Hash.file!(@slack_path, :sha)

  def twitter_handle(string, translate, font_size \\ 60),
    do: handle(@twitter_hash, string, translate, font_size, :twitter)

  def github_handle(string, translate, font_size \\ 60),
    do: handle(@github_hash, string, translate, font_size, :github)

  def slack_handle(string, translate, font_size \\ 60),
    do: handle(@slack_hash, string, translate, font_size, :slack)

  def handle(image, string, {x, y} = translate, font_size, id) do
    rect_id =
      id
      |> Atom.to_string()
      |> Kernel.<>("_logo")
      |> String.to_atom()

    text_id =
      id
      |> Atom.to_string()
      |> Kernel.<>("_handle")
      |> String.to_atom()

    Scenic.Cache.Static.Texture.load(@twitter_path, @twitter_hash)
    Scenic.Cache.Static.Texture.load(@github_path, @github_hash)
    Scenic.Cache.Static.Texture.load(@slack_path, @slack_hash)

    [
      rect_spec({60, 60}, fill: {:image, image}, t: {x - 80, y - 45}, id: rect_id),
      text_spec("@" <> string, fill: :black, font_size: font_size, t: translate, id: text_id)
    ]
  end
end
