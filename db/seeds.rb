# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
  [
    # pair1 二人ともアクティブ
    {partner_id: 2, pair_id:1, email: '1@1', name: 'user1', password: 'kinoko', oko_gauge: 0, is_active: true},
    {partner_id: 1, pair_id:1, email: '2@2', name: 'user2', password: 'kinoko', oko_gauge: 0, is_active: true},
    # pair2 片方が退会
    {partner_id: 4, pair_id:2, email: '3@3', name: 'user3', password: 'kinoko', oko_gauge: 0, is_active: true},
    {partner_id: 3, pair_id:2, email: '4@4', name: 'user4', password: 'kinoko', oko_gauge: 0, is_active: false},
    # pair3 一人しか登録していない
    {partner_id: nil, pair_id:3, email: '5@5', name: 'user5', password: 'kinoko', oko_gauge: 0, is_active: true}
  ]
)


Pair.create!(
  [
    {name: 'pair1', motto: 'なかよくしよう', pair_type: 0, rank: 0, is_paired: true, keyword: "きのこ"},
    {name: 'pair2', motto: '一日一笑', pair_type: 0, rank: 0, is_paired: true, keyword: "きのこ"},
    {name: 'pair3', motto: 'いい夫婦', pair_type: 0, rank: 0, is_paired: false, keyword: "きのこ"}
  ]
)
