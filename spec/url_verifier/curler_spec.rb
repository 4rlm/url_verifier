# rspec spec/url_verifier/curler_spec.rb

require 'spec_helper'

describe 'Curler' do
  let(:curler_obj) { UrlVerifier::Curler.new }

  describe '#start_curl' do
    let(:url) { "https://www.century1chevy.com" }
    let(:timeout) { 60 }
    let(:curl_result) do
      {:verified_url=>"http://www.centurychevy.com", :response_code=>"405", :curl_err=>nil}
    end

    it 'start_curl' do
      expect(curler_obj.start_curl(url, timeout)).to eql(curl_result)
    end
  end


  describe '#run_again' do
    let(:curl_result_in) do
      {:verified_url=>nil, :response_code=>nil, :curl_err=>"Error: Certificate"}
    end
    let(:url) { "https://www.century1chevy.com" }
    let(:timeout) { 60 }
    let(:curl_result_out) do
      {:verified_url=>"http://www.centurychevy.com", :response_code=>"405", :curl_err=>nil}
    end

    it 'run_again' do
      expect(curler_obj.run_again(curl_result_in, url, timeout)).to eql(curl_result_out)
    end
  end


  describe '#https_to_http' do
    let(:url_in) { "https://www.century1chevy.com" }
    let(:url_out) { "http://www.century1chevy.com" }

    it 'https_to_http' do
      expect(curler_obj.https_to_http(url_in)).to eql(url_out)
    end
  end


  describe '#pre_curl_msg' do
    let(:url) { "https://www.century1chevy.com" }
    let(:timeout) { 60 }
    let(:msg) { "\n\n========================================\nVERIFYING: https://www.century1chevy.com\nMax Wait Set: 60 Seconds\n\n" }

    it 'pre_curl_msg' do
      expect(curler_obj.pre_curl_msg(url, timeout)).to eql(msg)
    end
  end


  describe '#error_parser' do
    let(:curl_err_in) { "Error: Peer certificate cannot be authenticated with given CA certificates" }
    let(:curl_err_out) { "Error: Certificate" }

    it 'error_parser' do
      expect(curler_obj.error_parser(curl_err_in)).to eql(curl_err_out)
    end
  end


end
