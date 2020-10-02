require 'faker'

FactoryGirl.define do

  factory :hospital, class: Hospital do
    name { Faker::Name.unique.name }
    address { Faker::Name.unique.name }
    phone_number { Faker::PhoneNumber.cell_phone_in_e164 }
    sub_domain { name.delete(' ').delete('.').downcase }
  end

  factory :admin, class: User do
    name { Faker::Name.unique.name }
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password }
    password_confirmation { password }
    type 'Admin'
    confirmed_at Time.now
  end

  factory :doctor, class: User do
    name { Faker::Name.unique.name }
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password }
    type 'Doctor'
    registration_no { Faker::Number.digit }
    speciality { Faker::Name.unique.name }
    password_confirmation { password }
    consultancy_fee 200
    confirmed_at Time.now
  end

  factory :patient, class: User do
    name { Faker::Name.unique.name }
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password }
    gender { Faker::Name.unique.name }
    dob Date.current
    type 'Patient'
    confirmed_at Time.now
  end

  factory :availability do
    association :hospital, factory: :hospital
    association :doctor, factory: :doctor
    start_slot DateTime.current
    end_slot DateTime.current + 1.hour
    week_day 'Monday'
  end

  factory :appointment, class: Appointment do
    association :doctor, factory: :doctor
    association :patient, factory: :patient
    association :hospital, factory: :hospital
    association :availability, factory: :availability
    date DateTime.current
    state 'pending'
  end

  factory :medicine, class: Prescription do
    name { Faker::Name.unique.name }
    quantity { Faker::Number.digit }
    price { Faker::Number.number(digits: 3) }
    association :hospital, factory: :hospital
  end

  factory :prescription, class: Prescription do
    association :hospital, factory: :hospital
    association :appointment, factory: :appointment
  end

  factory :prescribed_medicine, class: PrescribedMedicine do
    association :hospital, factory: :hospital
    association :prescription, factory: :prescription
    association :medicine, factory: :medicine
    quantity { Faker::Number.digit }
    usage_instruction 'Day & Night'
  end

end
