FactoryGirl.define do
	factory :survivor do
		name 'Survivor Test'
		age '43'
		gender 'M'
		last_location ({latitude: '89809809809', longitude: '-88983982100'})
		infection_count 0

		factory :survivor_1 do
			name 'Survivor 1'
		end

		factory :survivor_2 do
			name 'Survivor 2'
			age '21'
			gender 'F'
			last_location ({latitude: '-82178299809', longitude: '-12375638001'})
			infection_count 0
		end
	end

	trait :infected do
		infection_count 3
	end

	trait :not_infected do
		infection_count 0
	end

	trait :almost_infected do
		infection_count 2
	end
end
