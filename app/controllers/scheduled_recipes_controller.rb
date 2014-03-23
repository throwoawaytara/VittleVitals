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

  def destroy
    all_scheduled_recipes = Recipe.find(params[:id]).scheduled_recipes
    all_scheduled_recipes.where(user_id: current_user.id,
                                day: params[:day],
                                recipe_id: params[:id]).first.destroy
    redirect_to "/users/#{current_user.id}/scheduled_recipes"
  end

  def meals_scheduled_for(day)
     @day_recipes = []
      current_user.scheduled_recipes.where(day: day).each do |schedule|
        @day_recipes << Recipe.where(id: schedule.recipe_id)
      end
      @day_recipes
  end
end


 # <li><a href="/users/<%= current_user.id %>/scheduled_recipes/<%= recipe[0].id %>/destroy">Delete</a></li>
 # <li><%= link_to 'Delete', recipe, :method => :delete, :confirm => "Are you sure?" %></li>
 # <%= button_to "Delete", { action: 'destroy', recipe_id: recipe[0].id }, method: :delete, data: { confirm: 'Are you sure?'} %>
 # <%= button_to "Delete", { action: 'destroy', recipe_id: recipe[0].id }, method: :delete, data: { confirm: 'Are you sure?'} %>
