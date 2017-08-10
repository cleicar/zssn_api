class Survivor
  include Mongoid::Document

  INFECTION_MAX = 3

  field :name, type: String
  field :age, type: String
  field :gender, type: String
  field :last_location, type: Hash

  field :infection_count, type: Integer, default: 0

  embeds_many :resources

  validates :name, :age, :gender, :last_location, :resources, :presence => true

  def build_resource(resource)
  	self.resources.build(type: resource[:type], quantity: resource[:quantity])
  end

  def infected?
    infection_count >= INFECTION_MAX
  end
end
