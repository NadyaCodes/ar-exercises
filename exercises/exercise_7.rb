require_relative '../setup'
require_relative './exercise_1'
require_relative './exercise_2'
require_relative './exercise_3'
require_relative './exercise_4'
require_relative './exercise_5'
require_relative './exercise_6'

puts "Exercise 7"
puts "----------"

# Your code goes here ...

class Employee < ActiveRecord::Base
  validates :first_name, {presence: true}
  validates :last_name, {presence: true}
  validates :hourly_rate, :numericality => { greater_than_or_equal_to: 40, less_than: 200 }
  validates :store_id, {presence: true}
end

class Store < ActiveRecord::Base
  validates :name, length: { minimum: 3 }
  validates :annual_revenue, :numericality => {greater_than_or_equal_to: 0, :message => "Annual Revenue must be greater than 0"}
  validate :must_carry_apparel

  def must_carry_apparel
    if !mens_apparel.present? && !womens_apparel.present?
      errors.add(:must_carry_apparel, "Must carry men's or women's clothing")
  end
end
end


# puts @store1.employees.create(last_name: "Michaels", hourly_rate: 40).valid?
# puts @store1.employees.create(first_name: "Michaels", hourly_rate: 200).valid?
# puts @store1.employees.create(first_name: "Michaels", last_name: "Michaels", hourly_rate: 12).valid?
# puts @store1.employees.create(store_id: nil, first_name: "Michaels", last_name: "Michaels", hourly_rate: 12).valid?
# puts Store.create(name: "Ga", annual_revenue: 190000, mens_apparel: true, womens_apparel: false).valid?
# puts Store.create(name: "Gav", annual_revenue: "pie", mens_apparel: true, womens_apparel: false).valid?
# puts Store.create(name: "Gav", annual_revenue: -3, mens_apparel: true, womens_apparel: false).valid?
# puts Store.create(name: "Gav", annual_revenue: 300, mens_apparel: false, womens_apparel: false).valid?
# puts @store1.employees.create(first_name: "Michaels", last_name: "Michaels", hourly_rate: 41).valid?
# puts Store.create(name: "Gav", annual_revenue: 300, mens_apparel: true, womens_apparel: false).valid?

puts "What should we call our new store?"
new_store_name = gets.chomp

new_store = Store.create(name: new_store_name)

new_store.errors.each do |message|
  puts "Error! #{message.message}"
end


# 1. Add validations to two models to enforce the following business rules:

# - Employees must always have a first name present
# - Employees must always have a last name present
# - Employees have a hourly_rate that is a number (integer) between 40 and 200
# - Employees must always have a store that they belong to (can't have an employee that is not assigned a store)
# - Stores must always have a name that is a minimum of 3 characters
# - Stores have an annual_revenue that is a number (integer) that must be 0 or more
# - BONUS: Stores must carry at least one of the men's or women's apparel (hint: use a [custom validation method](http://guides.rubyonrails.org/active_record_validations.html#custom-methods) - **don't** use a `Validator` class)

# 2. Ask the user for a store name (store it in a variable)
# 3. Attempt to create a store with the inputted name but leave out the other fields (annual_revenue, mens_apparel, and womens_apparel)
# 4. Display the error messages provided back from ActiveRecord to the user (one on each line) after you attempt to save/create the record
