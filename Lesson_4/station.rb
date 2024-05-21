require_relative 'instance_counter_module'

class Station
  include InstanceCounter

  attr_accessor :name
  attr_reader :trains
  
  @@stations = []

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    validate!
    register_instance
  end

  def self.all
    @@stations
  end  

  def take_train(train)
    @trains << train
  end
  
  def get_train_by_type(type)
    @trains.select{|train| train.type == type}.size 
  end 
      
  def send_train(train)
    @trains.delete(train)
  end

  def valid?
    validate!
  rescue StandardError
    false
  end
  
  protected

  def validate!
    raise "Name can't be nil" if name.nil?
    raise "Name should be at least 2 symbols" if name.length < 2
    true
  end  
end