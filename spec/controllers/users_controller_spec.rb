require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before(:each) do
    allow_any_instance_of(UserCreateWorker).to receive(:perform)

  end

  it 'should create user with proper params' do
    post :create, user: {
      name: 'test',
      email: Faker::Internet.email,
      phone_number: Faker::PhoneNumber.phone_number,
      address: 'test address',
      hobbies: 'test hobbies'
    }, format: 'json'
    result = ActiveSupport::JSON.decode(response.body)['user']
    expect(result['name']).to eq 'test'
  end

  it 'should not create user if email is not proper' do
    post :create, user: {
      name: 'test',
      email: "9999",
      phone_number: Faker::PhoneNumber.phone_number,
      address: 'test address',
      hobbies: 'test hobbies'
    }, format: 'json'
    result = ActiveSupport::JSON.decode(response.body)
    expect(result['status']).to eq 400
  end

  it 'should not create user if phone number is not proper' do
    post :create, user: {
      name: 'test',
      email: Faker::Internet.email,
      phone_number: "test",
      address: 'test address',
      hobbies: 'test hobbies'
    }, format: 'json'
    result = ActiveSupport::JSON.decode(response.body)
    expect(result['status']).to eq 400
  end

  it 'should list users' do
    FactoryGirl.create(:user)
    get :index, format: 'json'
    result = ActiveSupport::JSON.decode(response.body)['users']
    expect(result.length > 0).to eq true
  end

  it 'should give an user for given id' do
    user = FactoryGirl.create(:user)
    get :show, id: user.id, format: 'json'
    result = ActiveSupport::JSON.decode(response.body)['user']
    expect(result['id']).to eq user.id
  end

  it 'should give an error if user is not present for given id' do
    get :show, id: -1, format: 'json'
    result = ActiveSupport::JSON.decode(response.body)
    expect(result['status']).to eq 404
  end

  it 'should update the given user' do
    user = FactoryGirl.create(:user)
    post :update, id: user.id, user: { name: 'modified' }, format: 'json'
    result = ActiveSupport::JSON.decode(response.body)['user']
    expect(result['name']).to eq 'modified'
  end

  it 'should not update the given user' do
    user = FactoryGirl.create(:user)
    post :update, id: user.id, user: { email: 'test' }, format: 'json'
    result = ActiveSupport::JSON.decode(response.body)
    expect(result['status']).to eq 400
  end

  it 'should give search results' do
    user = FactoryGirl.create(:user,
      name: 'Book',
      email: Faker::Internet.email,
      phone_number: '999999',
      hobbies: 'test'
    )
    user = FactoryGirl.create(:user,
      name: 'test',
      email: Faker::Internet.email,
      phone_number: '999999',
      hobbies: 'Book reading'
    )
    post :search, user: { search: 'book' }, format: 'json'
    result = ActiveSupport::JSON.decode(response.body)['users']
    expect(result.length > 1).to eq true
    expect(result.last['hobbies']).to eq 'Book reading'
  end

  it 'should destroy a user' do
    user = FactoryGirl.create(:user)
    delete :destroy, id: user.id, format: 'json'
    result = ActiveSupport::JSON.decode(response.body)
    expect(User.find_by_id(user.id)).to eq nil
  end

  it 'should import users' do
    post :import_users, format: 'json', attachment: { name: 'test', attachment: Rack::Test::UploadedFile.new("spec/fixtures/sample_csv.csv", "csv") }
    get :index, format: 'json'
    result = ActiveSupport::JSON.decode(response.body)['users']
    expect(User.where(name: 'buden_csv').first.present?).to eq true

  end
end
