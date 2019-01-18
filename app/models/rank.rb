class Rank < ApplicationRecord
    #名前が入力されていること
    validates :name, presence: true
    validates :result, presence: true
    validates :resultdate, presence: true
    
end
