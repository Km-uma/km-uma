class Album < ApplicationRecord
    paginates_per 5
    belongs_to :user
    has_many_attached :images
   # attr_accessible :tag_list 
    acts_as_taggable_on :tags    

    validates :title, presence: true
    validates :discription, presence: true
    #validates :image_type 

    def thumbnail input
        return self.images[input].variant(resize: '300x300!').processed
    end
end

