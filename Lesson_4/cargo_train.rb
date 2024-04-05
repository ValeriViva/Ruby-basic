class CargoTrain < Train
  def initialize(number, type, train_length)
    super(number, :cargo, train_length)
  end 
end
  