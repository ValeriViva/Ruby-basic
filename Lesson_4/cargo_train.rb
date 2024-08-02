# frozen_string_literal: true

require_relative 'train'

class CargoTrain < Train
  def initialize(number, _type)
    super(number, :cargo)
  end
end
