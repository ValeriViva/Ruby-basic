# frozen_string_literal: true

require_relative 'train'

class PassengerTrain < Train
  def initialize(number, _type)
    super(number, :passenger)
  end
end
