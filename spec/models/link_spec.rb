require 'rails_helper'

RSpec.describe Link, type: :model do
  let(:valid_url){ 'https://stackoverflow.com/' }
  let(:invalid_url){ 'hello-world' }
  let(:valid_code){ '1234567' }
  let(:invalid_code){ '12345678' }

  describe '#validations' do
    context 'when invalid attributes are given' do
      it 'should not validate link with blank original url' do
        link = Link.new(original: '')
        expect(link.valid?).to be false
      end

      it 'should not validate link invalid url format' do
        link = Link.new(original: invalid_url, code: valid_code)
        expect(link.valid?).to be false
      end

      it 'should not create an object with existing code' do
        link1 = Link.create(original: valid_url, code: valid_code)
        link2 = Link.create(original: valid_url, code: valid_code)

        expect(link1.persisted?).to be true
        expect(link2.persisted?).to be false
      end

      it 'should not validate code of length greater than 7 characters' do
        link = Link.new(original: valid_url, code: invalid_code)
        expect(link.valid?).to be false
      end
    end

    context 'when valid attributes are given' do
      it 'should successfully validate link' do
        link = Link.new(original: valid_url, code: valid_code)
        expect(link.valid?).to be true

        link.save
        expect(link.persisted?).to be true
      end
    end
  end
end
