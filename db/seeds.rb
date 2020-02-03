# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Availability.destroy_all
Enrollment.destroy_all
TimeSlot.destroy_all
Booking.destroy_all
Room.destroy_all
Facility.destroy_all
Course.destroy_all
User.destroy_all

ActiveRecord::Base.connection.reset_pk_sequence!(:availabilities)
ActiveRecord::Base.connection.reset_pk_sequence!(:enrollments)
ActiveRecord::Base.connection.reset_pk_sequence!(:time_slots)
ActiveRecord::Base.connection.reset_pk_sequence!(:bookings)
ActiveRecord::Base.connection.reset_pk_sequence!(:rooms)
ActiveRecord::Base.connection.reset_pk_sequence!(:facilities)
ActiveRecord::Base.connection.reset_pk_sequence!(:courses)
ActiveRecord::Base.connection.reset_pk_sequence!(:users)

PASSWORD = "supersecret"
NUM_OF_USERS = 12

super_user = User.create(
  first_name: "Jon",
  last_name: "Snow",
  email: "js@winterfell.gov",
  contact_number: "33333333333",
  password: PASSWORD,
  is_admin: true
)

NUM_OF_USERS.times do |num|
  full_name = Faker::TvShows::SiliconValley.character.split(' ')
  first_name = full_name[0]
  last_name = full_name[1]
  u = User.create(
    first_name: first_name,
    last_name: last_name,
    email: "email#{num+1}@example.com",
    contact_number: Faker::PhoneNumber.cell_phone,
    password: 'supersecret'
  )
  if u.valid?
    u.is_manager = true if num % 3 == 1
    u.is_teacher = true if num % 3 == 2
    u.is_student = true if num % 3 == 0
    u.save()
  end
end

users = User.all
puts Cowsay.say("Created #{User.count} users", :tux)
puts Cowsay.say("Admin login with #{super_user.email} and password of '#{PASSWORD}'", :cow)
puts Cowsay.say("Users email are #{(users.map do |user| user.email end).join(', ')}", :kitty)

teachers = User.where({is_teacher: true})
20.times.map do
  teacher = teachers.sample
  c = Course.create(
    title: Faker::Educator.course_name,
    description: Faker::ChuckNorris.fact,
    capacity: 20,
    tuition: 100,
    status: "Open",
    user_id: teacher.id
  )
  if !c.valid?
    puts c.title, c.errors.full_messages.join(', ')
  end
end

puts Cowsay.say("Generated #{Course.count} courses using Faker.", :frogs)

students = User.where({is_student: true})
courses = Course.where({status:"Open"})
20.times.map do
  student = students.sample
  course = courses.sample
  e = Enrollment.create(
    status: "Enrolled",
    user_id: student.id,
    course_id: course.id
  )
end

puts Cowsay.say("Generated #{Enrollment.count} enrollments using Faker.", :sheep)

NUM_OF_FACILITIES = 5

managers = User.where({is_manager: true})

NUM_OF_FACILITIES.times do
  created_at = Faker::Date.backward(days: 20)
  manager = managers.sample
  f = Facility.create(
    name: Faker::Company.name,
    description: Faker::Company.catch_phrase,
    address: Faker::Address.street_address,
    city: Faker::Address.city,
    contact_number: "555-555-5555",
    parking: [true, false].sample,
    created_at: created_at,
    updated_at: created_at,
    user_id: manager.id
  )
  if f.valid?
    rand(0..10).times.each do
      r = Room.create(
        name: Faker::House.room,
        capacity: 25,
        area: Faker::Measurement.height,
        whiteboard: [true, false].sample,
        internet: [true, false].sample,
        created_at: created_at,
        updated_at: created_at,
        facility_id: f.id
      )

      a = Availability.create(
        start_date: Faker::Date.between(from: 2.days.from_now, to: 30.days.from_now),
        end_date: Faker::Date.between(from: 31.days.from_now, to: 60.days.from_now),
        start_time: "09:00",
        end_time: "17:00",
        one_hour_rental_price: 300,
        created_at: created_at,
        updated_at: created_at,
        room_id: r.id
      )
    end
  end
end

puts Cowsay.say("Generated #{Facility.count} facilities using Faker.", :frogs)
puts Cowsay.say("Generated #{Room.count} rooms using Faker.", :tux)
