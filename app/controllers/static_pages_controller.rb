class StaticPagesController < ApplicationController
  def home
  end

  def help
  end

  def about
  end

  def preview
    params[:edit].each do |key,value|
      @types = Type.find_all_by_description(value)
      @category = Category.find(key)
    end
    params[:edit].each{|key,value| puts key + " " + value}
    render :partial => 'preview', :content_type => 'text/html'
  end

  def ajax
    @categories = Category.all
  end
end
