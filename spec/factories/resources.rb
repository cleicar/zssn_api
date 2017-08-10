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

    trait :medication do
      type "Medication"
			quantity 16
    end		

    trait :ammunition do
      type "Ammunition"
			quantity 190
    end		
	end
end
