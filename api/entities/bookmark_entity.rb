class BookmarkEntity < Grape::Entity
	expose :id, :name, :url, :avatar, :category_id

end