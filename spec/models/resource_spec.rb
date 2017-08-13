require 'rails_helper'

RSpec.describe Resource, type: :model do

	it { is_expected.to be_mongoid_document }
	
	it { is_expected.to have_field(:type).of_type(String) }
	it { is_expected.to have_fields(:points, :quantity).of_type(Integer) }

	it { is_expected.to belong_to(:survivor) }
end