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

    def GetTwitchThumbnail(thumbnail)
        thumbnail.sub!(/{width}/,"300")
        thumbnail.sub!(/{height}/,"300")
        return thumbnail
    end

    def GetTwitchUserThumbnail(user_id)
        user_id = user_id.to_s
        url = "https://api.twitch.tv/helix/users?id=" + user_id
        uri = URI.parse(URI.encode(url))
        req = Net::HTTP.new(uri.host,uri.port)
        req.use_ssl = uri.scheme === "https"

        headers = {"Client-ID" => ENV['TWITCH_CLIENT_ID']}
        json = req.get(uri,headers)
        return JSON.parse(json.body)
    end
end
