# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#avatar_thumbnail" do
    let(:user) { create(:user) }

    context "when avatar is attached" do
      before do
        user.avatar.attach(io: File.open(Rails.root.join("spec/fixtures/default_avatar.jpg")), filename: "default_avatar.jpg", content_type: "image/jpg")
      end

      it "returns the attached avatar" do
        expect(user.avatar_thumbnail).to eq(user.avatar)
      end
    end

    context "when avatar is not attached" do
      it "returns 'default_avatar.jpg'" do
        expect(user.avatar_thumbnail).to eq("default_avatar.jpg")
      end
    end
  end
end
