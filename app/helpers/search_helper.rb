module SearchHelper
require 'net/http'
require 'uri'
require 'json'
def getYoutubeChannelJson(id)
    fields = "items(snippet/thumbnails/default/url)"
    key = ENV['YOUTUBE_KEY']
    jurl = "https://www.googleapis.com/youtube/v3/channels?part=snippet&id=" + id + "&fields=" + fields +  "&key=" + key
    uri = URI.parse(jurl)
    json = Net::HTTP.get(uri)
    return JSON.parse(json)
end
    def getYoutubeLiveJson(id)
        fields = "items(liveStreamingDetails/concurrentViewers)"
        key = ENV['YOUTUBE_KEY']
        jurl = "https://www.googleapis.com/youtube/v3/videos?id=" + id + "&fields=" + fields + "&part=liveStreamingDetails&key=" + key
        uri = URI.parse(jurl)
        json = Net::HTTP.get(uri)
        return JSON.parse(json)
    end
end
