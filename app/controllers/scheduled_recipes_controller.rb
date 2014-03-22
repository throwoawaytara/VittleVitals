class ScheduledRecipesController < ApplicationController
  def index
    if current_user
      @monday_recipes = meals_scheduled_for('2014-03-24')
      @tuesday_recipes = meals_scheduled_for('2014-03-25')
      @wednesday_recipes = meals_scheduled_for('2014-03-26')
      @thursday_recipes = meals_scheduled_for('2014-03-27')
      @friday_recipes = meals_scheduled_for('2014-03-28')

      # Need to link up each recipe
      # change date to a string and use Monday... as keyword to search by
      # Need to make some tables for the weekly recipes

    else
      redirect_to '/'
    end
  end

  def meals_scheduled_for(date)
     @day_recipes = []
      current_user.scheduled_recipes.where(date: date).each do |schedule|
        @day_recipes << Recipe.where(id: schedule.recipe_id)
      end
      @day_recipes
  end
end
