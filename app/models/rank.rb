class Rank < ApplicationRecord
    #カラムの名前をmount_uploaderに指定
    mount_uploader :recordimage, RecordimageUploader
    #名前が入力されていること
    validates :name, presence: true, length: {maximum: 15}
    validates :result, presence: true
    validates :dungeon, presence: true
    validates :movie_or_image, presence: true
    #validates_presence_of :movie, :unless => :recordimage?
    #validates_presence_of :recordimage, :unless =>:movie?

    #アーカイブのデータを取得する
    def self.GetArchive
        self.group("strftime('%Y%m', created_at)").order(Arel.sql("strftime('%Y%m', created_at) desc")).count
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
