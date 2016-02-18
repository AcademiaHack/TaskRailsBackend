class Category < ActiveRecord::Base
  validates :title, presence: true
  has_many :tasks, dependent: :destroy, autosave: true
  belongs_to :user

end
