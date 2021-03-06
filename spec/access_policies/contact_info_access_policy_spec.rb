require 'spec_helper'

RSpec.describe ContactInfoAccessPolicy do

  let!(:contact_info) { FactoryGirl.create :email_address }
  let!(:anon)         { AnonymousUser.instance }
  let!(:temp)         { FactoryGirl.create :temp_user }
  let!(:user)         { FactoryGirl.create :user }
  let!(:admin)        { FactoryGirl.create :user, :admin }
  let!(:app)          { FactoryGirl.create :doorkeeper_application }

  context 'read, create, destroy, toggle_is_searchable, resend_confirmation' do
    it 'cannot be accessed by applications or unauthorized users' do
      [:read, :create, :update,
       :toggle_is_searchable, :resend_confirmation].each do |act|
        expect(OSU::AccessPolicy.action_allowed?(act, app,
                                                 contact_info)).to eq false
        expect(OSU::AccessPolicy.action_allowed?(act, anon,
                                                 contact_info)).to eq false
        expect(OSU::AccessPolicy.action_allowed?(act, temp,
                                                 contact_info)).to eq false
        expect(OSU::AccessPolicy.action_allowed?(act, user,
                                                 contact_info)).to eq false
        expect(OSU::AccessPolicy.action_allowed?(act, admin,
                                                 contact_info)).to eq false
      end
    end

    it "can be accessed by the contact info's owner" do
      [:read, :create, :destroy,
       :toggle_is_searchable, :resend_confirmation].each do |act|
        expect(OSU::AccessPolicy.action_allowed?(act, contact_info.user,
                                                 contact_info)).to eq true
      end
    end
  end

  context 'confirm' do
    it 'can be accessed by anyone' do
      expect(OSU::AccessPolicy.action_allowed?(:confirm, anon,
                                               contact_info)).to eq true
      expect(OSU::AccessPolicy.action_allowed?(:confirm, app,
                                               contact_info)).to eq true
      expect(OSU::AccessPolicy.action_allowed?(:confirm, temp,
                                               contact_info)).to eq true
      expect(OSU::AccessPolicy.action_allowed?(:confirm, user,
                                               contact_info)).to eq true
      expect(OSU::AccessPolicy.action_allowed?(:confirm, admin,
                                               contact_info)).to eq true
    end
  end

end
