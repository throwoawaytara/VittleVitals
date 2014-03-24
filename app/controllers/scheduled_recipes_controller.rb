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
      # CODE REVIEW: It's good to set/display a flash message for the user
      # when you redirect because of an issue like this
      redirect_to '/'
    end
  end

  def destroy
    all_scheduled_recipes = Recipe.find(params[:id]).scheduled_recipes
    all_scheduled_recipes.where(user_id: current_user.id,
                                day: params[:day],
                                recipe_id: params[:id]).first.destroy
    # CODE REVIEW: why aren't you using path helpers?
    redirect_to "/users/#{current_user.id}/scheduled_recipes"
  end

  def meals_scheduled_for(day)
     @day_recipes = []
      current_user.scheduled_recipes.where(day: day).each do |schedule|
        # CODE REVIEW: why not schedule.recipe?
        @day_recipes << Recipe.where(id: schedule.recipe_id)
      end
      @day_recipes
  end
end
