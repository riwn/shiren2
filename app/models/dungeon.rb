class Dungeon < ApplicationRecord
    # DungeonのURIをみてあるかどうかを取得
    def self.GetUriDungeon(uriname)
        return self.where(uriname: uriname)
    end
end
