class Explanation < ApplicationRecord

    belongs_to :dungeon

    def self.GetExplanation(dungeon)
        return self.where(dungeon_id: dungeon)
    end
end
