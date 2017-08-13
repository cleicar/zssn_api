class Survivor
  include Mongoid::Document

  INFECTION_MAX = 3

  # Survivor's fields
  field :name, type: String
  field :age, type: String
  field :gender, type: String
  field :last_location, type: Hash

  field :infection_count, type: Integer, default: 0

  # Relationships
  has_many :resources
  accepts_nested_attributes_for :resources

  # Validations
  validates :name, :age, :gender, :last_location, :resources, :presence => true

  def infected?
    infection_count >= INFECTION_MAX
  end

  def has_enough_resources?(resources)
    resources.each do |resource|
      return false if resources_count(resource) < resource['quantity'].to_i
    end
    return true
  end

  def resources_count(resource)
    survivor_resource = self.resources.find_by(type: resource['type'])
    survivor_resource.present? ? survivor_resource.quantity : 0
  end

  scope :infecteds, -> do
    where(:infection_count.gte => 3)
  end
end
