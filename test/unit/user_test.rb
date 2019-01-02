require 'test_helper'
require 'spec_helper'

class UserTest < ActiveSupport::TestCase
  it 'should create user with proper params' do
    post :create, user: {
      name: 'test',
      email: Facker.email,
      phone_number: Facker.phone_number,
      address: 'test address',
      hobbies: 'test hobbies'
    }
    result = ActiveSupport::JSON.decode(response.body)['user']
    expect(result['id'].present?).eq to true
  end

  it 'should not create user if email is not proper' do
    post :create, user: {
      name: 'test',
      email: "9999"
      phone_number: Facker.phone_number,
      address: 'test address',
      hobbies: 'test hobbies'
    }
    result = ActiveSupport::JSON.decode(response.body)
    expect(result['errors'].present?).eq to true
  end

  it 'should not create user if phone number is not proper' do
    post :create, user: {
      name: 'test',
      email: Facker.email,
      phone_number: "test"
      address: 'test address',
      hobbies: 'test hobbies'
    }
    result = ActiveSupport::JSON.decode(response.body)
    expect(result['errors'].present?).eq to true
  end

  it 'should list users' do
    FactoryGirl.create(:user)
    get :index, format: 'json'
    result = ActiveSupport::JSON.decode(response.body)['users']
    expect(result.length > 0).eq to true
  end

  it 'should give an user for given id' do
    user = FactoryGirl.create(:user)
    get :show, id: user.id, format: 'json'
    result = ActiveSupport::JSON.decode(response.body)['user']
    expect(result['id']).eq to user.id
  end

  it 'should update the given user' do
    user = FactoryGirl.create(:user)
    post :update, id: user.id, user: { name: 'modified' } format: 'json'
    result = ActiveSupport::JSON.decode(response.body)['user']
    expect(result['name']).eq to 'modified'
  end
end
