class Expense < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_and_belongs_to_many :groups

  validates :name, presence: true, length: { minimum: 3, maximum: 100 }
  validates :amount, numericality: { greater_than: 0 }

  after_create :add_total_expense

  before_destroy :subtract_total_expense

  private

  def add_total_expense
    groups.each { |category| category.update(total_expenses: (category.total_expenses + amount)) }
  end

  def subtract_total_expense
    groups.each { |category| category.update(total_expenses: (category.total_expenses - amount)) }
  end
end
