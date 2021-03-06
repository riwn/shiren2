module ApplicationHelper
    def default_meta_tags
    {
        site: '風来のシレン2 タイムアタック番付',
        title: 'トップページ',
        reverse: true,
        charset: 'utf-8',
        description: 'ようこそ！このサイトは風来のシレン2のタイムアタック番付サイトです！タイムアタックの解説や大会のお知らせ、オンライン上のシレン2のコミュニティの管理等もしています。',
        keywords: '風来のシレン,風来のシレン2,タイムアタック,TA,RTA,シレン2番付,最果てへの道,最果てへの道99FTA,シレン2,最果て,最果てTA',
        canonical: request.original_url,
        separator: '|',
        icon: [
            { href: image_url('icons/favicon.ico') },
            { href: image_url('icons/icon.png'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/png' },
        ],
        og: {
            site_name: :site,
            title: :title,
            description: :description,
            type: 'website',
            image: image_url('icons/ogimage.png'),
            url: request.original_url,
            locale: 'ja_JP',
        },
        twitter: {
            card: 'summary',
            site: '@shiren2sougou',
            title: :title,
            description: :description,
            image: image_url('icons/ogimage.png'),
        }
    }
    end

    def ymconv(yyyymm)
        year = yyyymm[0,4].to_i
        month = yyyymm[4,2].to_i
        season = " "
        if(month == 1 || month == 2|| month == 3)
            season = "冬期"
        elsif(month == 4 || month == 5 || month == 6)
            season = "春期"
        elsif(month == 7 || month == 8|| month == 9)
            season = "夏期"
        elsif(month == 10 || month == 11 || month == 12)
            season = "秋期"
        end
        return year.to_s + "年" + season
        #return year.to_s + "年" + month + "月 (" + cnt + ")"
    end

    def GetResultTime(result)
        time = ""
            if result >= 3600 then
                time = (result.div(3600).to_s + "時間" + ((result.modulo(3600)).div(60)).to_s + "分" + ((result.modulo(3600)).modulo(60)).to_s + "秒")
            else
                time = ((result.div(60)).to_s + "分" + (result.modulo(60)).to_s + "秒")
            end
            return time
    end

    def RankColor(num)
        color = ""
        if(num == 1)
            color = "text-warning"
        elsif(num == 2)
            color = "text-success"
        elsif(num == 3)
            color = "text-info"
        else
            color = "text-dark"
        end
        return color
    end

    def devise_error_messages
        return "" if resource.errors.empty?

        html = ""
        messages = resource.errors.full_messages.each do |errmsg|
          html += <<-EOF
          <div class="alert alert-danger alert-dismissible" role="alert">
            <button type="button" class="close" data-dismiss="alert">
              <span aria-hidden="true">&times;</span>
              <span class="sr-only">close</span>
            </button>
            #{errmsg}
          </div>
          EOF
        end
        html.html_safe
    end

    def devise_error_messages?
        resource.errors.empty? ? false : true
    end
end
