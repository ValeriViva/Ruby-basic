# frozen_string_literal: true

require_relative 'company_module'
require_relative 'instance_counter_module'
require_relative 'cargo_carriage'
require_relative 'my_attr_accessor'
require_relative 'validation'

class Train
  include ManufacturingCompany
  include InstanceCounter
  include Validation
  extend MyAttrAccessor

  attr_accessor :speed, :number
  attr_reader :route, :type, :carriages
  attr_accessor_with_history :name, :a


  NUMBER_FORMAT = /^([a-я]{3}|\d{3})-?([a-я]{2}|\d{2})$/i.freeze

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT
  validate :type, :type, Symbol
  validate :carriages, :presence

  @@trains = []

  def initialize(number, type)
    @number = number
    @type = type
    @carriages = []
    validate!
    @@trains << self
    register_instance
  end

  def self.find(number)
    @@trains.find { |train| train.number == number }
  end

  def add_carriage(total_capacity)
    @total_capacity = total_capacity
    return unless speed.zero?

    carriage = create_carriage(total_capacity)
    @carriages << carriage
  end

  def delete_carriage
    return unless speed.zero?

    @carriages.delete_at(-1)
  end

  def add_route(route)
    @route = route
    @current_station_index = 0
    current_station.take_train(self)
  end

  def move_to_next_station
    return unless next_station

    current_station.send_train(self)
    next_station.take_train(self)
    @current_station_index += 1
  end

  def move_to_previous_station
    return unless previous_station

    current_station.send_train(self)
    previous_station.take_train(self)
    @current_station_index -= 1
  end

  def stop
    @speed = 0
  end

  def each_carriage(&block)
    carriages.each_with_index(&block)
  end

  #def valid?
    #validate!
    #true
  #rescue StandardError
    #false
  #end

  # protected #следующие методы не используются извне данного класса, но могут использоваться в наследуемых классах

  #def validate!
    #raise "Number can't be nil" if number.nil?
    #raise 'Number should be at least 5 symbols' if number.length < 5
    #raise 'Number has invalid format' if number !~ NUMBER_FORMAT
    #raise "Type can't be nil" if type.nil?
    #raise 'Type is invalid' unless type == :cargo || type == :passenger
  #end

  def current_station
    @route.stations[@current_station_index]
  end

  def next_station
    @route.stations[@current_station_index + 1] if @current_station_index + 1 < @route.stations.size
  end

  def previous_station
    @route.stations[@current_station_index - 1] if @current_station_index.positive?
  end

  def speed_increase
    @speed += 1
  end

  def create_carriage(total_capacity)
    if @type == :passenger
      PassengerCarriage.new(total_capacity)
    elsif @type == :cargo
      CargoCarriage.new(total_capacity)
    end
  end
end

train = Train.new("222-55", :cargo)
train.name = :art
train.name = :music
train.name = :cinima

train.a = 1
train.a = 22
train.a = 333

puts train.name_history
puts train.a_history