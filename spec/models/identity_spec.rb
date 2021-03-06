require 'spec_helper'

describe Identity do
  context 'password authentication' do
    before :each do
      @bcrypt = FactoryGirl.create :identity, password: 'password'
      @plone = FactoryGirl.create :identity
      @plone.update_attribute :password_digest, '{SSHA}RmBlDXdkdJaQkDsr790+eKaY9xHQdPVNwD/B'
    end

    it 'returns self if bcrypt password digest matches password' do
      expect(@bcrypt.authenticate 'password').to eq(@bcrypt)
    end

    it 'returns false if bcrypt password digest does not match password' do
      expect(@bcrypt.authenticate 'pass').to eq false
    end

    it 'returns self if ssha password digest matches password' do
      expect(@plone.authenticate 'password').to eq(@plone)
    end

    it 'returns false if ssha password digest does not match password' do
      expect(@plone.authenticate 'pass').to eq false
    end

    it 'returns false if ssha password digest is invalid' do
      @plone.update_attribute :password_digest, '{SSHA}%3D'
      expect(@plone.authenticate 'password').to eq false
    end
  end
end
