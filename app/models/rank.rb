class Rank < ApplicationRecord
    #カラムの名前をmount_uploaderに指定
    mount_uploader :recordimage, RecordimageUploader
    #名前が入力されていること
    validates :name, presence: true, length: {maximum: 15}
    validates :result, presence: true
    validates :dungeon, presence: true
    validates :movie_or_image, presence: true
    validate :both_true_vali
    #validates_presence_of :movie, :unless => :recordimage?
    #validates_presence_of :recordimage, :unless =>:movie?

    def both_true_vali
        if permission == true && rejection == true
            errors.add(:permission, " はrejectionがTrueの時,Trueには出来ません。")
        end
    end

    #アーカイブのデータを取得する
    def self.GetArchive
        self.group("DATE_FORMAT(created_at, '%Y%m')").order("DATE_FORMAT(created_at, '%Y%m') desc").count
    end

    #データベースからダンジョンに応じたデータを取得
    def self.RankDungeonChoose(dungname)
        return self.where(dungeon: dungname).where(permission: true)
    end

    private
        def movie_or_image
            recordimage.presence or movie.presence
        end
end
