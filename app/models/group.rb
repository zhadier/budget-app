class Group < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :expenses
  has_one_attached :icon

  validates :name, presence: true, length: { minimum: 3, maximum: 100 }
  validates :total_expenses, numericality: { only_integer: true }, comparison: { greater_than_or_equal_to: 0 }
  validates :icon, presence: true
end
