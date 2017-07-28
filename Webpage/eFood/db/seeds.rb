# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user_list = [
  [ 'mike123@gmail.com', 'Miguel', 'Lopez', '6646707333', 'password' ],
  [ 'javi123@gmail.com', 'Javier', 'Soto', '6643112390', 'password' ]
]

dish_list = [
  [ 1, 15, 50.5, 'Enchiladas Verdes' ],
  [ 1, 20, 70, 'Enchiladas Rojas' ],
  [ 1, 20, 80, 'Fetuccini Alfredo' ]
]

tag_list = [
  [ 'Italiana' ],
  [ 'Mexicana' ],
  [ 'Picante' ]
]

dish_tag_list = [
  [ 1, 2 ],
  [ 2, 2 ],
  [ 2, 3 ],
  [ 3, 1 ]
]

user_list.each do |email, fName, lName, cPhone, pWord|
    User.create(email: email, name: fName, last_name: lName, cellphone: cPhone, password: pWord)
end

Client.create(user_id: 1)

Seller.create(user_id: 2, kitchen_id: 1, brand_id: 1, RFC: 'HEGJ880317LS4', CLABE: '137027101868033404')

Payment.create(client_id: 1, name: "Miguel Lopez", street: "zumpango #4647", city: "Tijuana", state: "BC", postal_code: "22606", country: "MX", card_number: "5579079002242125", security_code: "556", expiry_date: "12/19")

Address.create(client_id: 1, street: "zumpango #4647", city: "Tijuana", state: "BC", postal_code: "22606", country: "MX")

Brand.create(seller_id: 1, name: "Mexican/Italian NiceFood")

Kitchen.create(seller_id: 1, brand_id: 1, name: "ComidaCorrida NiceFood", address: "Zumpango #4647 Col Jibarito", zone: "San Antonio de los Buenos")

dish_list.each do |kID, pTime, price, name|
    Dish.create(kitchen_id: kID, preparation_time: pTime, price: price, name: name)
end

tag_list.each do |name|
    Tag.create(name: name)
end

dish_tag_list.each do |dID, tID|
    DishesTag.create(dish_id: dID, tag_id: tID)
end