class ScheduledRecipesController < ApplicationController
  def index
    if current_user
      @monday_recipes = meals_scheduled_for('monday')
      @tuesday_recipes = meals_scheduled_for('tuesday')
      @wednesday_recipes = meals_scheduled_for('wednesday')
      @thursday_recipes = meals_scheduled_for('thursday')
      @friday_recipes = meals_scheduled_for('friday')

      # Need to link up each recipe
      # Need to make some tables for the weekly recipes
    else
      redirect_to '/'
    end
  end

  def meals_scheduled_for(day)
     @day_recipes = []
      current_user.scheduled_recipes.where(day: day).each do |schedule|
        @day_recipes << Recipe.where(id: schedule.recipe_id)
      end
      @day_recipes
  end
end
