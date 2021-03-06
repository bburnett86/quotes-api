class Quote < ApplicationRecord
  require 'net/http'

  def self.generate
    quotes_array = []
    self.delete_all
    uri = URI('https://gist.githubusercontent.com/anonymous/8f61a8733ed7fa41c4ea/raw/1e90fd2741bb6310582e3822f59927eb535f6c73/quotes.json')
    raw_quotes = Net::HTTP.get(uri)
    quotes_array = JSON.parse(raw_quotes)
    quotes_array.each do |quote|
      Quote.create(quote: quote["quote"], context: quote["context"], source: ["source"], theme: ["theme"])
    end
  end
end
