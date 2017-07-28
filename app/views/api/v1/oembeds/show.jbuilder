json.success @success
json.oembed do
  json.provider @res.fields['provider_name'].gsub(' ', '')
  json.html @res.fields['html']
  json.title @res.fields['title']
  json.author_url @res.fields['author_url']
  json.author_name @res.fields['author_name']
end
