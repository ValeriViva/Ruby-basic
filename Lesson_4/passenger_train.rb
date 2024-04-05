class PassengerTrain < Train
  def initialize(number, type, train_length)
    super(number, :passenger, train_length)
  end
end

  