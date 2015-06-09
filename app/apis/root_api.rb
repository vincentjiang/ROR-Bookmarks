class RootApi < Grape::API
  default_format :json

  mount V1::BaseApi

  add_swagger_documentation base_path: 'api', hide_format: true
end
