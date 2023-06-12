require 'nokogiri'
require 'open-uri'
require 'json'

# URLを指定
kakakucom_url = 'https://kakaku.com/item/J0000039558/spec/#tab'

# 指定したURLのページを開く
page = Nokogiri::HTML(URI.open(kakakucom_url))

# 必要な情報を抽出
product_name = page.css('div.productName h2').text
manufacturer = page.css('div.manufacturer').text
price = page.css('span.price').text
image_url = page.css('div.productImage img').attr('src').value
specs = page.css('div.specs').text
amazon_url = page.css('a.amazonLink').attr('href').value

# スペック情報をさらに抽出
spec_details = page.css('div.specDetails').map { |spec| spec.text.strip }

# 結果をJSON形式で出力
result = {
  'product_name' => product_name,
  'manufacturer' => manufacturer,
  'price' => price,
  'image_url' => image_url,
  'specs' => specs,
  'amazon_url' => amazon_url,
  'spec_details' => spec_details
}
puts JSON.pretty_generate(result)
