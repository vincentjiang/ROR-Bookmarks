module V1
  class BaseApi < Grape::API
    # 请求的时候，需要带参数Accept:application/vnd.owl-v1
    version 'v1', using: :header, vendor: :owl, strict: true
    format :json

    before do
      params.each { |k, v| params[k] = CGI.unescape v if v.is_a? String }
    end

    helpers V1::Helpers

    mount V1::UserApi
    mount V1::SessionApi
  end
end
