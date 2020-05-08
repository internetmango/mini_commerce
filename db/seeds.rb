# frozen_string_literal: true

# Add Users
users = User.create!(
  [
    { name: 'Admin User', email: 'admin@example.com', password: 'mangointernet', admin: true },
    { name: 'John Doe', email: 'user@example.com', password: 'mangointernet' },
    { name: 'Jane Roe', email: 'jane@example.com', password: 'mangointernet' }
  ]
)

# Add Categories
categories = Category.create!(
  [
    { name: 'Fruits & Vegetables' },
    { name: 'Foodgrains,Oil & Masala ' },
    { name: 'Beverages' },
    { name: 'Snacks & Branded Foods' }
  ]
)

# Add Products
categories.each_with_index do |category, index|
  products_data =
    [
      [
        {
          category_id: category.id,
          description: 'Onion is a vegetable which is
                        almostlike a staple in Indian
                        food.',
          name: 'Fresho Onion, 1 kg',
          price: 25
        },
        {
          category_id: category.id,
          description: 'Fresho Potatoes are nutrient-dense,
                        non-fatteningand have reasonable
                        amount of calories.',
          name: 'Fresho Potato, 1 kg',
          price: 39
        },
        {
          category_id: category.id,
          description: 'Local tomatoes are partly sour and partly
                        sweet and contain many seeds inside which
                        are edible.',
          name: 'Fresho Tomato - Local, 1 kg',
          price: 15
        },
        {
          category_id: category.id,
          description: 'Ladies finger is a green vegetable with a tip at the
                        end and a lighter green head, which is inedibe and to
                        be thrown away.',
          name: 'Fresho Ladies Finger, 250 g',
          price: 10
        },
        {
          category_id: category.id,
          description: 'A popular sweet-tasting root vegetable,
                        Carrots are narrow and cone shaped.',
          name: 'Fresho Carrot - Local, 500 g',
          price: 20
        },
        {
          category_id: category.id,
          description: 'Cauliflower is made up of tightly bound clusters of soft,
                        crumbly, sweet cauliflower florets that form a dense head. ',
          name: 'Fresho Cauliflower, 1 pc.',
          price: 25
        }
      ],
      [
        {
          category_id: category.id,
          description: 'Urad Whole is used for various purposes besides
                        retaining the skins and also has a strong flavor.',
          name: 'bb Royal Organic - Urad Whole (Gota), Unpolished, 1 kg',
          price: 172
        },
        {
          category_id: category.id,
          description: 'Phool Makhana or popped lotus seeds is an organic
                        non-cereal nutritious food which is normally found
                        in the stagnant water of lakes, tanks, ponds and
                        wetlands.',
          name: 'bb Royal Phool Makhana, 100 g',
          price: 119
        },
        {
          category_id: category.id,
          description: 'Urad Whole is used for various purposes besides
                        retaining the skins and also has a strong flavor.',
          name: 'bb Royal Organic - Urad Whole (Gota), Unpolished,  500',
          price: 72
        },
        {
          category_id: category.id,
          description: 'Phool Makhana or popped lotus seeds is an organic
                        non-cereal nutritious food which is normally found
                        in the stagnant water of lakes, tanks, ponds and
                        wetlands.',
          name: 'bb Royal Phool Makhana, 1 kg',
          price: 219
        },
        {
          category_id: category.id,
          description: 'Urad Whole is used for various purposes besides
                        retaining the skins and also has a strong flavor.',
          name: 'bb Royal Organic - Urad Whole (Gota), Unpolished, 2 kg',
          price: 272
        },
        {
          category_id: category.id,
          description: 'Phool Makhana or popped lotus seeds is an organic
                        non-cereal nutritious food which is normally found
                        in the stagnant water of lakes, tanks, ponds and
                        wetlands.',
          name: 'bb Royal Phool Makhana, 500 g',
          price: 179
        }
      ],
      [
        {
          category_id: category.id,
          description: 'Perfect companion for happy bodies everywhere.',
          name: 'Aquafina Packaged Drinking Water, 24x500 ml Multipack',
          price: 270
        },
        {
          category_id: category.id,
          description: 'Perfect companion for happy bodies everywhere.',
          name: 'Aquafina Packaged Drinking Water, 24x100 ml Multipack',
          price: 70
        },
        {
          category_id: category.id,
          description: 'Taj Mahal Teas are Tasted, graded and perfectly
                        blendedat the Brooke bond Tea Excellence Centre',
          name: 'Taj Mahal Tea, 2x1 kg Multipack',
          price: 1140
        },
        {
          category_id: category.id,
          description: 'Taj Mahal Teas are Tasted, graded and perfectly
                        blendedat the Brooke bond Tea Excellence Centre',
          name: 'Taj Mahal Tea, 2x2 kg Multipack',
          price: 2140
        },
        {
          category_id: category.id,
          description: 'Nescafe Sunrise is an instant coffee-chicory mixture
                        made from 70% coffee powder and 30% chicory. ',
          name: 'Nescafe Sunrise Instant Coffee - Chicory Mixture, 50 g Pouch',
          price: 90
        },
        {
          category_id: category.id,
          description: 'Nescafe Sunrise is an instant coffee-chicory mixture
                        made from 70% coffee powder and 30% chicory.',
          name: 'Nescafe Sunrise Instant Coffee - Chicory Mixture, 100 g Pouch',
          price: 180
        }
      ],
      [
        {
          category_id: category.id,
          description: 'India’s favourite Masala Noodles, MAGGI
                        2-minute Noodles, now comes with the
                        goodness of Iron. ',
          name: 'MAGGI 2-Minute Instant Noodles - Masala, 280 g Pouch',
          price: 46
        },
        {
          category_id: category.id,
          description: 'India’s favourite Masala Noodles, MAGGI
                        2-minute Noodles, now comes with the
                        goodness of Iron. ',
          name: 'MAGGI 2-Minute Instant Noodles - Masala, 500 g Pouch',
          price: 92
        },
        {
          category_id: category.id,
          description: 'Start your morning with a wholesome bowl of Quaker
                        Oats- the perfect breakfast porridge for the whole
                        family. ',
          name: 'Quaker Oats, 600 g Pouch',
          price: 184
        },
        {
          category_id: category.id,
          description: 'Start your morning with a wholesome bowl of Quaker
                        Oats- the perfect breakfast porridge for the whole
                        family. ',
          name: 'Quaker Oats, 1 kg Pouch',
          price: 354
        },
        {
          category_id: category.id,
          description: 'Fresho! brings to you frozen green peas of uniform size that is
                        peeled, sorted and packed in our state-of-the-art facilities.',
          name: 'Fresho Frozen Green Peas, 1 kg Slider Zip Standy Pouch',
          price: 159
        },
        {
          category_id: category.id,
          description: 'Fresho! brings to you frozen green peas of uniform size that is
                        peeled, sorted and packed in our state-of-the-art facilities.',
          name: 'Fresho Frozen Green Peas, 2 kg Slider Zip Standy Pouch',
          price: 300
        }
      ]
    ]
  @products = Product.create!(products_data[index])
end

# Upload image
uploader = ImageUploader.new(:store)
image_path = 'db/assets/images/seed/'
images = [
  "#{image_path}bio.jpg",
  "#{image_path}natural.jpg",
  "#{image_path}organic_n_fresh.jpg"
]
images.each do |image|
  file = File.new(Rails.root.join(image))
  uploaded_file = uploader.upload(file)
  @products.each do |product|
    product.product_images.create! image_data: uploaded_file.to_json
  end
end

# Banner items
banner_items =
  BannerItem.create!(
    [
      {
        title: '20% off for survival kit',
        image_url: 'https://source.unsplash.com/Hz4FAtKSLKo/400x300'
      },
      {
        title: 'Vegetable kit for Rs.120',
        image_url: 'https://source.unsplash.com/ks5flsI1mNo/400x300'
      },
      {
        title: 'Bellpeppers 10% off',
        image_url: 'https://source.unsplash.com/T4K9vJ7Mmf4/400x300'
      }
    ]
  )

# New Order
order = users[0].orders.create(status: 'cart', deleted_at: nil)
current_cart = ShopingCart.new(order: order)
current_cart.add_item( product_id: @products[0].id, quantity: 5 )
current_cart.add_item( product_id: @products[1].id, quantity: 3 )

# Shipping Methods
shipping_methods =
  ShippingMethod.create!(
    [
      { name: 'Same-day delivery', code: 'sdd', value_type: 'flat_rate', value: 20 },
      { name: 'Overnight shipping', code: 'os', value_type: 'flat_rate', value: 20 },
      { name: 'International shipping', code: 'is', value_type: 'flat_rate', value: 20 }
    ]
  )

# Payment Methods
payment_method =
  PaymentMethod.create!(
    [
      {
        name: 'Online Payment',
        description: 'electronic payment system is a way of
                      paying for a goods or services electronically,
                      instead of using cash or a check, in person or
                      by mail.',
        provider: 'Stripe::Order',
        active: false
      },
      {
        name: 'Cash on Delivery',
        description: 'payment is made on delivery rather than in
                      advance. If the goods are not paid for, they
                      are returned to the retailer.',
        provider: 'CashOnDelivery::Order',
        active: false
      }
    ]
  )

# Add Tax Rate
tax_rates =
  TaxRate.create!(
    [
      { name: '5% GST', rate: 5 },
      { name: '18% GST', rate: 18 }
    ]
  )

# Add Address
address =
  users[0].addresses.create!(
    [

      {
        address_line1: 'KFON',
        address_line2: 'Kadavanthra',
        city: 'cochin',
        zipcode: '22313',
        state: 'Kerala',
        country: 'India',
        phone: 8_848_925_291
      }
    ]
  )

# Feature Products
featured_products =
  FeaturedProduct.create!(
    [
      { product_id: @products[0].id },
      { product_id: @products[1].id },
      { product_id: @products[2].id },
      { product_id: @products[3].id }
    ]
  )

# Wishlist Items
wishlist_item =
  users[0].wishlist_items.create!(
    [
      { product_id: @products[1].id },
      { product_id: @products[2].id },
      { product_id: @products[3].id },
    ]
  )
