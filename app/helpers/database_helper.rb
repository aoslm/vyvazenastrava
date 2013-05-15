module DatabaseHelper
  def dropAll
    User.delete_all
    Food.delete_all
    Composition.delete_all

    Menu.delete_all
    Category.delete_all
    Type.delete_all
    MenusFood.delete_all
    FoodsType.delete_all
    Recipe.delete_all
    TypesCategory.delete_all
    UsersMenu.delete_all
    UsersRecipe.delete_all
  end
end
