class CategoryEntity < Grape::Entity
	expose :id, :name

	expose :bm_count do |object, instance|
		object.bookmarks.count
	end
end