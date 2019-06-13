require 'json'
require 'net/http'

module Elo
  class Giphy
    def self.random(rating: 'pg', tag: 'taunt')
      endpoint = 'https://api.giphy.com/v1/gifs/random'
      params = URI.encode_www_form(
        'api_key' => 'kOfZLcXch58quEHKmp1jfYry4D5JVVrp',
        'rating' => rating,
        'tag' => tag
      )
      req_uri = URI.parse("#{endpoint}?#{params}")

      response = JSON.parse(Net::HTTP.get(req_uri), object_class: OpenStruct).data
      response.url
    end
  end
end
