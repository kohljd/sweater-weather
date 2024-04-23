require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    it { should have_secure_password }
    it { should validate_confirmation_of :password }
    it { should validate_presence_of :password }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }

    it { should allow_value("something@something.something").for(:email) }
    it { should_not allow_value("something somthing@something.something").for(:email) }
    it { should_not allow_value("something.something@").for(:email) }
    it { should_not allow_value("something").for(:email) }
  end
end