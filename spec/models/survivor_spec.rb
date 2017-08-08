require 'rails_helper'

RSpec.describe Survivor, type: :model do

	let(:attributes){
		{
			"name"=>"Survivor Test", 
			"age" => '43',
			"gender" => 'M',
			"last_location" => {"latitude": '89809809809', "longitude": '-88983982100'}
		}
	}

	let(:new_survivor){
		FactoryGirl.create(:survivor)
	}

	describe "Validating survivor's fields" do 		
		before do 
			FactoryGirl.create(:survivor)
		end

		it "should be a valid survivor" do 
			expect(new_survivor).to be_valid
		end

		it "should have all survivor's fields" do
			created_survivor = Survivor.last

			expect(created_survivor.attributes).to include :name
			expect(created_survivor.attributes).to include :age
			expect(created_survivor.attributes).to include :gender
			expect(created_survivor.attributes).to include :last_location

			created_survivor.attributes.delete("_id")

			expect(created_survivor.attributes).to eq attributes.with_indifferent_access
		end
	end

	describe "Testing relationships" do
	end

end
