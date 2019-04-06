module SearchHelper
require 'net/http'
require 'uri'
require 'json'
    def getYoutubeChannelJson(id)
        jurl = "https://www.googleapis.com/youtube/v3/channels?part=snippet&id=" + id + "&key=AIzaSyBSMUGQr3MrHqncwqmjNFJHTz-la052tW8"
        uri = URI.parse(jurl)
        json = Net::HTTP.get(uri)
        return JSON.parse(json)
    end
    def getYoutubeLiveJson(id)
        jurl = "https://www.googleapis.com/youtube/v3/videos?id=" + id + "&part=liveStreamingDetails&key=AIzaSyBSMUGQr3MrHqncwqmjNFJHTz-la052tW8"
        uri = URI.parse(jurl)
        json = Net::HTTP.get(uri)
        return JSON.parse(json)
    end
end
