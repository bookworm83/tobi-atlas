require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {
    User.create!(
      email: "user@example.com",
      username: "tester",
      password: "pass123",
      password_confirmation: "pass123"
    )
  }

  it "should not update password, if the confirmation is not the same" do
    expect {
      user.update!(password: "newpass123", password_confirmation: "different")
    }.to raise_error(ActiveRecord::RecordInvalid)

    expect(user.reload.authenticate("pass123")).to be_truthy
  end

  it "should not exceed the maximum length of the Bio" do
    expect {
      user.update!(bio: "a" * User::MAX_BIO_LENGTH + "b")
    }.to raise_error
  end

  it "should update bio with the maximum length" do
    expect(user.update!(bio: "a" * User::MAX_BIO_LENGTH)).to be_truthy
  end
end
