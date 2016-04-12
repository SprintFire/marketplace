require 'airborne'
require 'api_helper'

describe 'sample spec' do
  it 'should get all users' do
    get '/users'
    expect_json_types(:array)
  end
end
