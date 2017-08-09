class Survivor
  include Mongoid::Document

  field :name, type: String
  field :age, type: String
  field :gender, type: String
  field :last_location, type: Hash

  embeds_many :resources

  validates :name, :age, :gender, :last_location, :resources, :presence => true

  def build_resource(resource)
  	self.resources.build(type: resource[:type], quantity: resource[:quantity])
  end
end
