module ApplicationHelper
    def ymconv(yyyymm,cnt)
        year = yyyymm[0,4].to_i
        month = yyyymm[4,2].to_i
        season = " "
        if(month == 3 || month == 4|| month == 5)
            season = "春期"
        elsif(month == 6 || month == 7 || month == 8)
            season = "夏期"
        elsif(month == 9 || month == 10|| month == 11)
            season = "秋期"
        elsif(month == 12 || month == 1|| month == 2)
            season = "冬期"
            if(month == 1|| month == 2)
                year = year - 1
            end
        end
        return year.to_s + "年" + season
        #return year.to_s + "年" + month + "月 (" + cnt + ")"
    end
end
