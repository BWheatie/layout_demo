# defmodule AssetsManager do
#   def read_and_hash_file(app_name, file_path, asset_name, hash_type \\ :sha) do
#     path = Application.app_dir(app_name, file_path)
#     hash = Scenic.Cache.Support.Hash.file!(path, :sha)

#     {path, hash}
#   end
# end
