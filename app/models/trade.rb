class Trade
  include Mongoid::Document

  attr_accessor :trade_params, :survivor_1, :survivor_2, :status, :message

  def initialize(params)
    super

    @survivor_1   = Survivor.find(params['survivor_1']['id'])
    @survivor_2   = Survivor.find(params['survivor_2']['id'])

    @trade_params = [params['survivor_1'], params['survivor_2']]
  end

  def process  
    validate_survivors
  rescue Exception => error
    @status  = :conflict
    @message = error.message
    return false
  end

  private

  def validate_survivors
  	survivors.each_with_index do |survivor, index|
  		if survivor.blank?
  			raise "Survivor with id #{trade_params[index]['id']} does not exist"
  		end
  	end
  end

  def survivors
  	[survivor_1, survivor_2]
  end
end
