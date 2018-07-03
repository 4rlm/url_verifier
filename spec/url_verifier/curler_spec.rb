# rspec spec/url_verifier/curler_spec.rb
require 'spec_helper'

describe 'Curler' do
  let(:curler_obj) { UrlVerifier::Curler.new }
  # before { curler_obj.inst = inst }

  describe '#start_curl' do
    let(:url) {}
    let(:timeout) {}
    let(:curl_result) {}

    it 'meth_name' do
      expect(curler_obj.meth_name(url, timeout)).to eql(curl_result)
    end
  end


  describe '#run_again' do
    let(:curl_result) {}
    let(:url) {}
    let(:timeout) {}
    let(:curl_result) {}

    it 'run_again' do
      expect(curler_obj.run_again(curl_result, url, timeout)).to eql(curl_result)
    end
  end


  describe '#https_to_http' do
    let(:url_in) {}
    let(:url_out) {}

    it 'https_to_http' do
      expect(curler_obj.https_to_http(url_in)).to eql(url_out)
    end
  end


  describe '#pre_curl_msg' do
    let(:url) {}
    let(:timeout) {}
    let(:msg) {}

    it 'pre_curl_msg' do
      expect(curler_obj.pre_curl_msg(url, timeout)).to eql(msg)
    end
  end


  describe '#error_parser' do
    let(:curl_err_in) {}
    let(:curl_err_out) {}

    it 'error_parser' do
      expect(curler_obj.error_parser(curl_err_in)).to eql(curl_err_out)
    end
  end


end
