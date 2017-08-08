FactoryGirl.define do
	factory :survivor do
		name 'Survivor Test'
		age '43'
		gender 'M'
		last_location ({latitude: '89809809809', longitude: '-88983982100'})
	end
end
