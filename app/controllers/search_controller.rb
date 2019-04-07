require 'net/http'
require 'uri'
require "open-uri"
require 'json'

class SearchController < ApplicationController
    def result
        @result = getNicoLiveJson("風来のシレン2","シレン2")
        @result = @result["data"]
        @result2 = getLiveJson("風来のシレン2","シレン2")
        @result2 = @result2["items"]
    end

    def getLiveJson(word1,word2 = nil,word3 = nil)
        word = word1
        if(word2 != nil)
            word = word +"|" + word2
            if(word3!=nil)
                word = word + "|" + word3
            end
        end
        key = "AIzaSyBSMUGQr3MrHqncwqmjNFJHTz-la052tW8"
        url = "https://www.googleapis.com/youtube/v3/search?&q=" + word + "&type=video&part=snippet&eventType=live&key=" + key
        uri = URI.parse(URI.encode(url))
        json = Net::HTTP.get(uri)
        return JSON.parse(json)
    end

    def getNicoLiveJson(word1,word2 = nil,word3 = nil)
        target = "title"
        word = word1
        if(word2 != nil)
            word = word + " OR " + word2
            if(word3!=nil)
                word = word + " OR " + word3
            end
        end
        url = "https://api.search.nicovideo.jp/api/v2/live/contents/search?q=" + word + "&targets=" + target + "&fields=contentId,title,viewCounter,communityIcon&filters[liveStatus][0]=onair&_sort=viewCounter"
        uri = URI.parse(URI.encode(url))
        json = Net::HTTP.get(uri)
        return JSON.parse(json)
    end
end
