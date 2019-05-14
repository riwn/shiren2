class Rank < ApplicationRecord
    #カラムの名前をmount_uploaderに指定
    mount_uploader :recordimage, RecordimageUploader
    #名前が入力されていること
    validates :name, presence: true
    validates :result, presence: true
    validates :dungeon, presence: true
end
