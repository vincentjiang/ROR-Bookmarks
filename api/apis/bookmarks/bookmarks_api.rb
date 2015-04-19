class Bookmarks::BookmarksAPI < ApplicationAPI

	helpers do 
		def bookmark_params
			params.symbolize_keys.slice(:name, :url, :category_id)
		end
	end

	before do
    authenticate!
  end

  desc "获取某分类下的书签"
  params do
  	optional :category_id, type: Integer
  end
  get do
  	bookmarks = current_user.bookmarks.where(category_id: params[:category_id])
  	present :bookmarks, bookmarks, with: BookmarkEntity
  end


	desc "新建书签"
	params do
		requires :name, type: String
		requires :url, type: String
		optional :category_id, type: Integer
		optional :category_name, type: String
	end
	post :create do
		if params[:category_name].present?
			category = current_user.categories.create(name: params[:category_name])
			params[:category_id] = category.id
		end
		current_user.bookmarks.create(bookmark_params)
	end

	desc "批量删除书签"
	params do
		requires :bookmark_ids, type: Array
	end
	delete :destroy do
		bookmarks = Bookmark.where(id: params[:bookmark_ids])
		bookmarks.each do |bookmark|
			bookmark.destroy
		end
		present :msg, "成功删除"
	end
end