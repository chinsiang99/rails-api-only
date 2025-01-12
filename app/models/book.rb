class Book < ApplicationRecord
  validates :title, presence: true, on: :create
  validates :author, presence: true, on: :create
end
