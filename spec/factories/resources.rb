FactoryGirl.define do
	factory :resource do
		
		trait :water do
      type "Water"
			quantity 10
    end

    trait :food do
      type "Food"
			quantity 6
    end		
	end
end
