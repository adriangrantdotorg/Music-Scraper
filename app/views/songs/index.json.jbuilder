json.array!(@songs) do |song|
  json.extract! song, :title, :youtubeid, :bloglink, :source
  json.url song_url(song, format: :json)
end
