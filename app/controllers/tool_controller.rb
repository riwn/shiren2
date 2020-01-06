require 'net/http'
require 'uri'
require "open-uri"
require 'json'

class ToolController < ApplicationController
    def search
        @result = getNicoLiveJson("風来のシレン2","シレン2")
        @result = @result["data"]
        @result2 = getLiveJson("シレン2")
        @result2 = @result2["items"]
        @result3 = getTwitchLiveJson(26133)
        @result3 = @result3["data"]
    end

    def counter

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

    def getTwitchLiveJson(game_id)
        shiren2_id = game_id.to_s
        url = "https://api.twitch.tv/helix/streams?game_id=" + shiren2_id
        uri = URI.parse(URI.encode(url))
        req = Net::HTTP.new(uri.host,uri.port)
        req.use_ssl = uri.scheme === "https"

        headers = {"Client-ID" => ENV['TWITCH_CLIENT_ID']}
        json = req.get(uri,headers)
        return JSON.parse(json.body)
    end
end
