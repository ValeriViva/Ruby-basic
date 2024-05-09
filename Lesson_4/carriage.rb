require_relative 'company_module'

class Carriage
  include ManufacturingCompany

  attr_reader :type
  
  def initialize(type)
  end  
end

  