require 'rails_helper'

RSpec.describe UsersSerializer do
  before(:each) do
    @user = create(:user)
    @serializer = UsersSerializer.new(@user)  

    @serialization = ActiveModelSerializers::Adapter.create(@serializer)
  end

  it 'should have an email that matches' do
    expect(subject['email']).to eql(@sample.email)
  end

  it 'should have an password and password confirmation that matches' do
    expect(subject['password']).to eql(@sample.password)
    expect(subject['password_confirmation']).to eql(@sample.password)
  end
end
