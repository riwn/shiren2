require 'net/http'
require 'uri'
require "open-uri"
require 'json'

class SearchController < ApplicationController
    def result
        @result = getNicoLiveJson("風来のシレン2","シレン2")
        @result = @result["data"]
        @result2 = getLiveJson("シレン2")
        @result2 = @result2["items"]
    end

    def getLiveJson(word1)
        word = word1
        key = ENV['YOUTUBE_KEY']
        fields = "items(id/videoId,snippet/title,snippet/channelId)"
        type = "video"
        url = "https://www.googleapis.com/youtube/v3/search?&q=" + word + "&type=" + type +"&fields=" + fields +"&part=snippet&eventType=live&key=" + key
        uri = URI.parse(URI.encode(url))
        json = Net::HTTP.get(uri)
        return JSON.parse(json)
    end

    def getNicoLiveJson(word1,word2)
        target = "title"
        word = word1 + " OR " + word2
        url = "https://api.search.nicovideo.jp/api/v2/live/contents/search?q=" + word + "&targets=" + target + "&fields=contentId,title,viewCounter,communityIcon&filters[liveStatus][0]=onair&_sort=viewCounter"
        uri = URI.parse(URI.encode(url))
        json = Net::HTTP.get(uri)
        return JSON.parse(json)
    end
end
