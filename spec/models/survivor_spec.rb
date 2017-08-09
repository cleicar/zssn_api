require 'rails_helper'

RSpec.describe Survivor, type: :model do

	describe "Testing survivor's fields" do
		it { is_expected.to have_fields(:name, :age).of_type(String) }
		it { is_expected.to have_field(:last_location).of_type(Hash) }
	
		it { is_expected.to be_mongoid_document }

		it { is_expected.to validate_presence_of(:name) }
		it { is_expected.to validate_presence_of(:age) }
		it { is_expected.to validate_presence_of(:gender) }
		it { is_expected.to validate_presence_of(:last_location) }
		it { is_expected.to validate_presence_of(:resources) }
	end

	describe "Testing relationships" do		
		it { is_expected.to embed_many :resources }
	end

end
