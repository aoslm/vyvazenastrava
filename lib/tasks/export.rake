namespace :export do
  desc "Prints Food.all in a seeds.rb way."

  task :seeds_food => :environment do
    Food.order(:id).all.each do |food|
      puts "Food.create(#{food.serializable_hash.delete_if { |key, value| ['created_at', 'updated_at', 'id'].include?(key) }.to_s.gsub(/[{}]/, '')})"
    end
  end

  task :seeds_category => :environment do
    Category.order(:id).all.each do |food|
      puts "Category.create(#{food.serializable_hash.delete_if { |key, value| ['created_at', 'updated_at', 'id'].include?(key) }.to_s.gsub(/[{}]/, '')})"
    end
  end

  task :seeds_type => :environment do
    Type.order(:id).all.each do |food|
      puts "Type.create(#{food.serializable_hash.delete_if { |key, value| ['created_at', 'updated_at', 'id'].include?(key) }.to_s.gsub(/[{}]/, '')})"
    end
  end

  task :seeds_composition => :environment do
    Composition.order(:id).all.each do |food|
      puts "Composition.create(#{food.serializable_hash.delete_if { |key, value| ['created_at', 'updated_at',
                                                                        'id'].include?(key) }.to_s.gsub(/[{}]/, '')})"
    end
  end

  task :seeds_element => :environment do
    Element.order(:id).all.each do |food|
      puts "Element.create(#{food.serializable_hash.delete_if { |key, value| ['created_at', 'updated_at',
                                                                                  'id'].include?(key) }.to_s.gsub(/[{}]/, '')})"
    end
  end

  task :seeds_elements_type => :environment do
    ElementsType.order(:id).all.each do |food|
      puts "ElementsType.create(#{food.serializable_hash.delete_if { |key, value| ['created_at', 'updated_at',
                                                                              'id'].include?(key) }.to_s.gsub(/[{}]/, '')})"
    end
  end

  task :seeds_foods_type => :environment do
    FoodsType.order(:id).all.each do |food|
      puts "FoodsType.create(#{food.serializable_hash.delete_if { |key, value| ['created_at', 'updated_at',
                                                                                   'id'].include?(key) }.to_s.gsub(/[{}]/, '')})"
    end
  end


  task :seeds_types_category => :environment do
    TypesCategory.order(:id).all.each do |food|
      puts "TypesCategory.create(#{food.serializable_hash.delete_if { |key, value| ['created_at', 'updated_at',
                                                                                'id'].include?(key) }.to_s.gsub(/[{}]/, '')})"
    end
  end
  desc "Prints all database in a seeds.rb way."

  task :seeds_all => :environment do
    Category.order(:id).all.each do |food|
      puts "Category.create(#{food.serializable_hash.delete_if { |key, value| ['created_at', 'updated_at', 'id'].include?(key) }.to_s.gsub(/[{}]/, '')})"
    end
    Type.order(:id).all.each do |food|
      puts "Type.create(#{food.serializable_hash.delete_if { |key, value| ['created_at', 'updated_at', 'id'].include?(key) }.to_s.gsub(/[{}]/, '')})"
    end
    Food.order(:id).all.each do |food|
      puts "Food.create(#{food.serializable_hash.delete_if { |key, value| ['created_at', 'updated_at', 'id'].include?(key) }.to_s.gsub(/[{}]/, '')})"
    end
    Composition.order(:id).all.each do |food|
      puts "Composition.create(#{food.serializable_hash.delete_if { |key, value| ['created_at', 'updated_at',
                                                                                  'id'].include?(key) }.to_s.gsub(/[{}]/, '')})"
    end
    TypesCategory.order(:id).all.each do |food|
      puts "TypesCategory.create(#{food.serializable_hash.delete_if { |key, value| ['created_at', 'updated_at',
                                                                                    'id'].include?(key) }.to_s.gsub(/[{}]/, '')})"
    end
    FoodsType.order(:id).all.each do |food|
      puts "FoodsType.create(#{food.serializable_hash.delete_if { |key, value| ['created_at', 'updated_at',
                                                                                'id'].include?(key) }.to_s.gsub(/[{}]/, '')})"
    end
    ElementsType.order(:id).all.each do |food|
      puts "ElementsType.create(#{food.serializable_hash.delete_if { |key, value| ['created_at', 'updated_at',
                                                                                   'id'].include?(key) }.to_s.gsub(/[{}]/, '')})"
    end
    Element.order(:id).all.each do |food|
      puts "Element.create(#{food.serializable_hash.delete_if { |key, value| ['created_at', 'updated_at',
                                                                              'id'].include?(key) }.to_s.gsub(/[{}]/, '')})"
    end
    ElementTypeGroup.order(:id).all.each do |food|
      puts "ElementTypeGroup.create(#{food.serializable_hash.delete_if { |key, value| ['created_at', 'updated_at',
                                                                              'id'].include?(key) }.to_s.gsub(/[{}]/, '')})"
    end
    User.order(:id).all.each do |food|
      puts "User.create(#{food.serializable_hash.delete_if { |key, value| ['created_at', 'updated_at',
                                                                                       'id'].include?(key) }.to_s.gsub(/[{}]/, '')})"
    end

  end

end