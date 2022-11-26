require 'open-uri'
require 'nokogiri'

url = 'https://qiita.com/search?page=1&q=ruby&sort=like'
res = OpenURI.open_uri(url)
body = res.read


charset = res.charset
html = Nokogiri::HTML.parse(body, nil, charset)

results = []

html.search('.css-ocoetd').each do |node|
  title = node.css('h1.css-1l1igte a').text
  tags = node.css('.css-ncaq81').map(&:text)
  detail = node.css('.css-5sjjbm').text
  results << { title: title, tags: tags, detail: detail }
end

results.each.with_index(1) do |result, i|
  puts "#{i}番目の投稿"
  puts "Title: #{result[:title]}"
  puts "Tags: #{result[:tags]}"
  puts "Detail: #{result[:detail]}"
  puts "--------------------------"
end
