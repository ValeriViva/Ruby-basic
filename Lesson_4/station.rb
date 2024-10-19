# frozen_string_literal: true

require_relative 'instance_counter_module'
require_relative 'validation'

class Station
  include InstanceCounter
  include Validation

  attr_accessor :name
  attr_reader :trains

  validate :name, :presence
  validate :trains, :presence

  @@stations = []

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self
    register_instance
  end

  def self.all
    @@stations
  end

  def take_train(train)
    @trains << train
  end

  def get_train_by_type(type)
    @trains.select { |train| train.type == type }.size
  end

  def send_train(train)
    @trains.delete(train)
  end

  def each_train(&block)
    @trains.each(&block)
  end

  # def valid?
  #   validate!
  # rescue StandardError
  #   false
  # end

  # protected

  # def validate!
  #   raise "Name can't be nil" if name.nil?
  #   raise 'Name should be at least 2 symbols' if name.length < 2
  # end
end
