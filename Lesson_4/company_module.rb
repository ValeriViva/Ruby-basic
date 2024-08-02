# frozen_string_literal: true

module ManufacturingCompany
  def company_name(name)
    @company_name = name
  end

  def display_company_name
    @company_name
  end

  # protected
  # attr_accessor :company_name
end
