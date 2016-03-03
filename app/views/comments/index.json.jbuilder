json.array!(@comments) do |comment|
  json.extract! comment, :id, :star_rating, :body
  json.url comment_url(comment, format: :json)
end
