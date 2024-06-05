
# db/seeds.rb

products = [
{ name: 'TV', description: 'Indicates a positive reaction to the content' ,price: 20000},
  { name: 'fridge', description: 'Indicates a negative reaction to the content',price: 30000 },
  { name: 'glass', description: "Indidcates that the blog is informative",price: 20}

]

products.each do |product|
    Product.find_or_create_by(name: product[:name]) do |r|
    r.description = product[:description]
    r.price = product[:price]
  end
end



