require_relative 'instance_counter_module'

class Station
  include InstanceCounter

  attr_reader :trains, :name
  
  @@stations = []

  def initialize(name)
    @name = name
    @trains = []
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
    @trains.select{|train| train.type == type}.size 
  end 
      
  def send_train(train)
    @trains.delete(train)
  end    
end