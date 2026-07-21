require 'rails_helper'

RSpec.describe Trip, type: :model do
  let(:user) {
    User.create!(
      email: "user@example.com",
      username: "tester",
      password: "pass123",
      password_confirmation: "pass123")
  }

  it "is not valid without a name" do
    trip = Trip.new(name: nil)
    expect(trip).not_to be_valid
  end

  it "is not valid without a start date" do
    trip = Trip.new(name: "Singapore", notes: nil, user: user, start_date: nil, end_date: "2027-08-05")
    expect(trip).not_to be_valid
  end

  it "cannot be that the end date is before the start date" do
    trip = Trip.new(name: "Greece", notes: nil, user: user, start_date: "2027-04-16", end_date: "2027-04-05")
    expect(trip).not_to be_valid
  end

  it "calculates the duration in nights between start and end date" do
    trip = Trip.new(name: "Norfolk", notes: nil, user: user, start_date: "2027-06-07", end_date: "2027-06-10")
    expect(trip.duration_nights).to eq(3)
  end

  it "is valid without notes" do
    trip = Trip.new(name: "Sahara", notes: nil, user: user, start_date: "2027-04-16", end_date: "2027-05-05")
    expect(trip).to be_valid
  end

  describe ".search" do
    it "finds trips whose name matches the query, case-insensitively" do
      trip = Trip.create!(name: "Panama", notes: nil, user: user, start_date: "2028-03-12", end_date: "2028-04-06")
      trip2 = Trip.create!(name: "Panam2", notes: nil, user: user, start_date: "2028-03-12", end_date: "2028-04-06")
      expect(Trip.search("Panama")).to include(trip)
      expect(Trip.search("Panama")).not_to include(trip2)
    end
  end
end
