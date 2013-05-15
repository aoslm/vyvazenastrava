#encoding: utf-8
class MenusController < ApplicationController


  def remove_food_from_menu
    @food = Food.find(params[:food_id])
    @menu = Menu.find(params[:menu_id])
    if (@menu.users.first == current_user)
      MenusFood.destroy_all(:menu_id => @menu.id, :food_id => @food.id)
      if @food.rank > 1
        @food.update_attribute("rank", @food.rank-1)
      end
      flash[:success] = "Z menu bolo úspešne odstránené jedlo " + @food.slovakname
      redirect_to menu_path(@menu)
    else
      flash[:error] = "Nemôžeš vymazať jedlo iného používateľa."
      redirect_to foods_path
    end
  end

  def index
    @menus = Menu.order("rank DESC").limit(100);
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @menus }
    end
  end

  def add
    menu = Menu.find(params[:id])
    u = UsersMenu.where(user_id: current_user.id, menu_id: menu.id);
    if u.empty?
      UsersMenu.create(user: current_user, menu: menu)
      menu.rank = menu.rank + 1
      menu.save
      redirect_to menu_path(menu)
    else
      flash[:error] = "Jedálny lístok sa už v tvojom zozname nachádza."
      redirect_to menus_path
    end
  end

  def show #rychlejsie to nejde :(
    @menu = Menu.includes(:foods, :menus_foods).find(params[:id])
    @prvok = []

    ElementsType.all.each do |elements_type|
      sum = 0
      @menu.foods.each do |food|
        element = Element.where(elements_type_id: elements_type.id, composition_id: food.compositions.first.id).first
        #element = food.compositions.first.elements.find_by_elements_type_id(elements_type.id)
        #element = elements_type.elements.find_by_composition_id(food.compositions.first.id)
        sum += (element.amount * @menu.menus_foods.find_by_food_id(food.id).amount/100) unless element.nil?
      end

      case current_user.gender
        when "man"
          gda = elements_type.GDA_man
        when "woman"
          gda = elements_type.GDA_woman
        when "child"
          gda = elements_type.GDA_child
        else
          gda = elements_type.GDA_man
      end

      @prvok.append(sum => {elements_type.name => {elements_type.unit => gda}})
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @menus }
    end
  end

  def new
    @menu = Menu.new()

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @menu }
    end
  end

  def create
    @menu = Menu.new(params[:menu])
    @menu.rank = 1
    UsersMenu.create(user: current_user, menu: @menu);

    if @menu.save
      flash[:success] = 'Menu bolo úspešne vytvorené.'
      redirect_to menus_path
    else
      render 'new'
    end

  end

  def update
    puts params

    menu = Menu.find(params[:format])

    if (menu.users.first == current_user)
      params[:filter].each do |key, value|
        food = Food.find(key)
        menufood = MenusFood.where(food_id: key, menu_id: params[:format]).first
        menufood.amount = value
        menufood.save
      end
      flash[:success] = "V jedálnom lístku boli úspešne zmenené množstvá jedál."
    else
      flash[:error] = "Nemôžeš meniť jedálny lístok iného používateľa."
      end



      redirect_to menu
    end
  end
