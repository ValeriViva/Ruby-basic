class Station
  attr_reader :trains, :name
  
  def initialize(name)
    @name = name
    @trains = []
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