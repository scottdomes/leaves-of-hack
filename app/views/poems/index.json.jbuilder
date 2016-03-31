json.array!(@poems) do |poem|
  json.extract! poem, :id, :title, :content, :user_id
  json.url poem_url(poem, format: :json)
end
