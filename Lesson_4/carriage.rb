# frozen_string_literal: true

require_relative 'company_module'
# require_relative 'cargo_carriage'

class Carriage
  include ManufacturingCompany

  attr_accessor :occupied_capacity
  attr_reader :type, :total_capacity

  def initialize(total_capacity)
    @total_capacity = total_capacity
    @occupied_capacity = 0
    validate!
  end

  def available_capacity
    @total_capacity - @occupied_capacity
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  protected

  def validate!
    # raise "Format of total_capacity should be numeric" if total_capacity.str
  end
end
