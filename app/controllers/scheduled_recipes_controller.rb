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

  def create
    ScheduledRecipe.create(recipe_params)
    redirect_to user_recipes_path
  end

  def destroy
    all_scheduled_recipes = Recipe.find(params[:id]).scheduled_recipes
    all_scheduled_recipes.where(user_id: current_user.id,
                                day: params[:day],
                                recipe_id: params[:id]).first.destroy

    redirect_to user_scheduled_recipes_path(current_user.id)
  end

  def meals_scheduled_for(day)
     @day_recipes = []
      current_user.scheduled_recipes.where(day: day).each do |schedule|
        schedule.recipe?
        # @day_recipes << Recipe.where(id: schedule.recipe_id)
      end
      @day_recipes
  end

  private
  def recipe_params
    params.permit(:day, :recipe_id, :user_id)
  end
end
