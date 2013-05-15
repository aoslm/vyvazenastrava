# encoding: utf-8

class FoodsController < ApplicationController

  handles_sortable_columns
  autocomplete :food, :slovakname
  include FoodsHelper


  def statistic
    get_max
  end

  def index
    @categories = Category.includes(:types).all
    order = sortable_column_order
    @foods = Food.order("rank desc").limit(100)
    get_my_menu
    @groups = ElementTypeGroup.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @foods }
    end
  end

  def search
    @foods = Set.new

    Food.kinda_spelled_like(params[:search]).each do |food|
      @foods.add(food)
    end
    Food.gringo_search(params[:search]).each do |food|
      @foods.add(food)
    end

    get_my_menu

    render :partial => 'search', :content_type => 'text/html'

  end


  def filter
    @foods = Set.new
    get_my_menu
    @params = params[:filter]
    do_filter
    render :partial => 'search', :content_type => 'text/html'
  end

  def accept(food, value, key)
    x = food.compositions.first.elements.find_by_elements_type_id(ElementsType
                                                                  .find_by_name(key).id)
    if x.nil?
      return false #true ak nema uvedenu danu ingredienciu a ma to zobrazit false ak ho nema zobrazit
    elsif (x.amount >= value.to_f)
      return true
    else
      return false
    end
  end


  def preview
    get_my_menu

    params[:edit].each do |key, value|
      @category = Category.find(key)
      @type = Type.find_by_description(value)
    end

    @foods = []

    @type.foods.includes(:category).each { |food| @foods.append(food) if food.category == @category }

    @foods.sort()

    render :partial => 'preview', :content_type => 'text/html'
  end

  def new
    @food = Food.new
    @categories = Category.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @food }
    end
  end

  def edit
    if current_user != getFood.user
      flash[:error] = "Nemôžeš upraviť detaily jedla ktoré si sám nepridal"
      render "details"
    end
  end

  def update
    getFood
    if @food.update_attributes(params[:food])
      @food.types = Type.find(params[:types])
      flash[:success] = 'Detaily jedla boli úspešne zmenené.'
      redirect_to details_food_path(@food)
    else
      flash[:error] = "Nové detaily sa nepodarilo uložiť"
      redirect_to edit_food_path(@food)
    end
  end


  def create
    @food = Food.new(params[:food])
    @food.user = current_user
    @food.types = Type.find(params[:types])

    #@food.category = Category.find(params[:category_id])
    if @food.save
      flash[:success] = 'Jedlo bolo úspešne vytvorené.'
      redirect_to details_food_path(@food)
    else
      render 'new'
    end
  end

  def details
    @food = Food.find(params[:id])
    if !@food.compositions.empty?
      @elements = @food.compositions.first.elements.sort
    end
  end

  def destroy
    getFood
    if (@food.user == current_user || current_user == User.find_by_username('admin'))
      @food.destroy
      flash[:success] = "Jedlo bolo úspešne odstránené."
      redirect_to foods_path
    else
      flash[:error] = "Nemôžeš vymazať jedlo iného používateľa."
      redirect_to foods_path
    end
  end

  def elements
    @elements = ElementsType.all
  end

  def view
    @foods = @user.foods
  end

end