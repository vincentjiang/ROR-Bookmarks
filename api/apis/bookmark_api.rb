class BookmarkAPI < Grape::API
  format :json

  rescue_from :all, :backtrace => true
  # error_formatter :json, ErrorFormatter

  # helpers ApplicationHelpers
  helpers SessionHelpers

  mount UsersAPI
  mount SessionsAPI

  namespace :bookmarks do
    mount Bookmarks::BookmarksAPI
    mount Bookmarks::CategoriesAPI
  end
  # mount AccountsAPI
  # mount RelatedResourcesAPI
  # mount SearchAPI
  # mount MenusAPI


  # route :any, '*path' do
  #   not_found!
  # end

end
