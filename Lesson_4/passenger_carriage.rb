# frozen_string_literal: true

require_relative 'carriage'

class PassengerCarriage < Carriage
  def initialize(total_capacity)
    @type = :passenger
    @occupied_capacity = 0
    super(total_capacity)
  end

  def take_seats
    if available_capacity >= 1
      @occupied_capacity += 1
    else
      puts 'Свободных мест нет'
    end
  end
end
