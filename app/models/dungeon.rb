class Dungeon < ApplicationRecord

    has_one :rank

    # DungeonのURIをみてあるかどうかを取得
    def self.GetUriDungeon(uriname)
        return self.where(uriname: uriname)
    end
end
