class Post < ApplicationRecord
    belongs_to :category
    belongs_to :user
    has_many :comments

    has_rich_text :body

    validates :title, presence: true
    validates :category_id, presence: true
    validates :body, presence: true

    has_attached_file :image, :default_url => "rails1.jpg"
    validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

    def self.search(query)
        where("title like ? OR body like ?", "%#{query}%", "%#{query}%")
    end

    def as_json(options={})
      { :title => self.title }  # Only including title for the API
    end
end
