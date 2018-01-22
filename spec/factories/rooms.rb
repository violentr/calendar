FactoryBot.define do
  factory :room do
    sequence(:number) {|n| n += 10 }
    name Faker::StarWars.specie
    size 'single'
  end
end
