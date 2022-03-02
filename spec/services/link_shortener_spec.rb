require 'rails_helper'

RSpec.describe LinkShortener do
  let(:valid_url) { 'https://stackoverflow.com/' }
  let(:invalid_url) { 'hello-world' }

  context 'when a valid url is used to construct LinkShortener object instance' do
    let(:shortener) { LinkShortener.new(url: valid_url)}
    it 'should create a Link record with a unique code even with the same url' do
      link1 = shortener.shorten
      link2 = shortener.shorten

      expect(link1.persisted?).to be true
      expect(link2.persisted?).to be true
      expect(link1.code).not_to be eq link2.code
    end

    it 'should create a Link record with a 7 characters generated unique code' do
      link = shortener.shorten
      expect(link.code.length).to eq 7
    end
  end

  context 'when an invalid url is used to construct LinkShortener object instance' do
    let(:shortener) { LinkShortener.new(url: invalid_url)}

    it 'should generate a 7 characters unique code' do
      link = shortener.shorten
      expect(link.code.length).to eq 7
    end

    it 'should not create a Link record' do
      link = shortener.shorten
      expect(link.persisted?).to be false
    end
  end

end