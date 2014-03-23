class ScheduledRecipesController < ApplicationController
  def index
    if current_user

      @weekday_recipes = {
        'monday' => meals_scheduled_for('monday'),
        'tuesday' => meals_scheduled_for('tuesday'),
        'wednesday' => meals_scheduled_for('wednesday'),
        'thursday' => meals_scheduled_for('thursday'),
        'friday' => meals_scheduled_for('friday')
      }

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
