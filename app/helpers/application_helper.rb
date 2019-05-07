module ApplicationHelper
    def ymconv(yyyymm,cnt)
        yyyy = yyyymm[0,4]
        mm = yyyymm[4,2]
        month = mm.to_i
        season = " "
        if(month == 1 || month == 2|| month == 12)
            season = "冬期"
        elsif(month == 11 || month == 10|| month == 9)
            season = "秋期"
        elsif(month == 6 || month == 7 || month == 8)
            season = "夏期"
        elsif(month == 3 || month == 4|| month == 5)
            season = "春期"
        end
        return yyyy + "年" + season
        #return yyyy + "年" + mm + "月 (" + cnt + ")"
    end
end
