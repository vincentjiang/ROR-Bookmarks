class Bookmarks::CategoriesAPI < ApplicationAPI

	resources :categories do
		before do
    	authenticate!
  	end
  	desc "获取书签分类列表"
		get do
			categories = current_user.categories
			present :categories, categories, with: CategoryEntity
		end


		desc "新建书签分类"
		params do
			requires :name, type: String
		end
		post do
			category = current_user.categories.create(name: params[:name])
			present :category, category
		end

	end


end