# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
class Article < ApplicationRecord
    has_one_attached :eyecatch
    has_rich_text :content

    validates :title, presence: true
    validates :title, length: {minimum: 4, maximum: 100}
    validates :title, format: {with: /\A(?!\@)/ }

    validates :content, presence: true


    has_many :comments, dependent: :destroy
    has_many :likes, dependent: :destroy
    belongs_to :user

    def self.top_like
        self.left_joins(:likes).group(:id).order('COUNT(likes.id) DESC')
    end
end
