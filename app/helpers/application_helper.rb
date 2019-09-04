module ApplicationHelper
    def ymconv(yyyymm)
        year = yyyymm[0,4].to_i
        month = yyyymm[4,2].to_i
        season = " "
        if(month == 1 || month == 2|| month == 3)
            season = "冬期"
            year = year - 1
        elsif(month == 4 || month == 5 || month == 6)
            season = "春期"
        elsif(month == 7 || month == 8|| month == 9)
            season = "夏期"
        elsif(month == 10 || month == 11 || month == 12)
            season = "秋期"
        end
        return year.to_s + "年度" + season
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
end
