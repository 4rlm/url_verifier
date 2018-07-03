# rspec spec/url_verifier/run_curler_spec.rb
require 'spec_helper'

describe 'RunCurler' do
  let(:run_obj) { UrlVerifier::RunCurler.new }
  # before { run_obj.inst = inst }

  describe '#verify_urls' do
    let(:array_of_urls) {}
    let(:url_hashes) {}

    it 'verify_urls' do
      expect(run_obj.verify_urls(array_of_urls)).to eql(url_hashes)
    end
  end


  describe '#verify_url' do
    let(:url) {}
    let(:url_hash) {}

    it 'verify_url' do
      expect(run_obj.verify_url(url)).to eql(url_hash)
    end
  end


  describe '#merge_url_hash' do
    let(:url_hash_in) {}
    let(:url_hash_out) {}

    it 'merge_url_hash' do
      expect(run_obj.merge_url_hash(url_hash_in)).to eql(url_hash_out)
    end
  end


  describe '#evaluate_formatted_url' do
    let(:url_hash_in) {}
    let(:url_hash_out) {}

    it 'evaluate_formatted_url' do
      expect(run_obj.evaluate_formatted_url(url_hash_in)).to eql(url_hash_out)
    end
  end



  describe '#check_for_redirect' do
    let(:url_hash_in) {}
    let(:url_hash_out) {}

    it 'check_for_redirect' do
      expect(run_obj.check_for_redirect(url_hash_in)).to eql(url_hash_out)
    end
  end


  describe '#send_to_curl' do
    let(:url_hash_in) {}
    let(:url_hash_out) {}

    it 'send_to_curl' do
      expect(run_obj.send_to_curl(url_hash_in)).to eql(url_hash_out)
    end
  end


  describe '#evaluate_curl_err' do
    let(:curl_err) {}
    let(:output) {}

    it 'evaluate_curl_err' do
      expect(run_obj.evaluate_curl_err(curl_err)).to eql(output)
    end
  end



end
