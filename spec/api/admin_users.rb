require 'airborne'
require 'api_helper'

describe 'Admin Users' do
  it 'List all admin users' do
    get '/admin_users'
    expect_json_types(:array)
  end
end
