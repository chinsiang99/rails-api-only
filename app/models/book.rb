class Book < ApplicationRecord
  validates :title, presence: true, length: { minimum: 3 }, on: :create
  # validates :author, presence: true, length: { minimum: 3 }, on: :create

  belongs_to :author
end
