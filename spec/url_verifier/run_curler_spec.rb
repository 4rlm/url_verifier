# rspec spec/url_verifier/run_curler_spec.rb

require 'spec_helper'

describe 'RunCurler' do
  let(:run_obj) { UrlVerifier::RunCurler.new }
  before { run_obj.time_now = 'rspec_time' }

  describe '#verify_urls' do
    let(:array_of_urls) do
      %w[https://www.century1chevy.com]
    end

    let(:url_hashes) do
      [
        {:web_status=>"unchanged",
        :url=>"https://www.century1chevy.com",
        :url_f=>"https://www.century1chevy.com",
        :url_path=>nil,
        :web_neg=>nil,
        :verified_url=>"http://www.centurychevy.com",
        :url_redirected=>true,
        :response_code=>"405",
        :url_sts=>"Valid",
        :url_date=>'rspec_time',
        :wx_date=>nil,
        :timeout=>0}
      ]
    end

    it 'verify_urls' do
      expect(run_obj.verify_urls(array_of_urls)).to eql(url_hashes)
    end
  end


  describe '#verify_url' do
    let(:url) { "https://www.century1chevy.com" }
    let(:url_hash) do
      {:web_status=>"unchanged",
       :url=>"https://www.century1chevy.com",
       :url_f=>"https://www.century1chevy.com",
       :url_path=>nil,
       :web_neg=>nil,
       :verified_url=>"http://www.centurychevy.com",
       :url_redirected=>true,
       :response_code=>"405",
       :url_sts=>"Valid",
       :url_date=>'rspec_time',
       :wx_date=>nil,
       :timeout=>0}
    end

    it 'verify_url' do
      expect(run_obj.verify_url(url)).to eql(url_hash)
    end
  end


  describe '#merge_url_hash' do
    let(:url_hash_in) do
      {:web_status=>"unchanged", :url=>"https://www.century1chevy.com", :url_f=>"https://www.century1chevy.com", :url_path=>nil, :web_neg=>nil}
    end

    let(:url_hash_out) do
      {:web_status=>"unchanged",
       :url=>"https://www.century1chevy.com",
       :url_f=>"https://www.century1chevy.com",
       :url_path=>nil,
       :web_neg=>nil,
       :verified_url=>nil,
       :url_redirected=>false,
       :response_code=>nil,
       :url_sts=>nil,
       :url_date=>'rspec_time',
       :wx_date=>nil,
       :timeout=>0}
    end

    it 'merge_url_hash' do
      expect(run_obj.merge_url_hash(url_hash_in)).to eql(url_hash_out)
    end
  end


  describe '#evaluate_formatted_url' do
    let(:url_hash_in) do
      {:web_status=>"invalid",
       :url=>"https://www.sofake.sofake",
       :url_f=>nil,
       :url_path=>nil,
       :web_neg=>"error: ext.invalid [sofake]",
       :verified_url=>nil,
       :url_redirected=>false,
       :response_code=>nil,
       :url_sts=>nil,
       :url_date=>nil,
       :wx_date=>nil,
       :timeout=>0}
    end

    let(:url_hash_out) do
      {:web_status=>"invalid",
       :url=>"https://www.sofake.sofake",
       :url_f=>nil,
       :url_path=>nil,
       :web_neg=>"error: ext.invalid [sofake]",
       :verified_url=>nil,
       :url_redirected=>false,
       :response_code=>nil,
       :url_sts=>"Invalid",
       :url_date=>nil,
       :wx_date=>'rspec_time',
       :timeout=>0}
    end

    it 'evaluate_formatted_url' do
      expect(run_obj.evaluate_formatted_url(url_hash_in)).to eql(url_hash_out)
    end
  end



  describe '#check_for_redirect' do
    let(:url_hash_in) do
      {:web_status=>"unchanged",
       :url=>"https://www.century1chevy.com",
       :url_f=>"https://www.century1chevy.com",
       :url_path=>nil,
       :web_neg=>nil,
       :verified_url=>"http://www.centurychevy.com",
       :url_redirected=>false,
       :response_code=>"405",
       :url_sts=>"Valid",
       :url_date=>'rspec_time',
       :wx_date=>nil,
       :timeout=>0}
    end

    let(:url_hash_out) do
      {:web_status=>"unchanged",
       :url=>"https://www.century1chevy.com",
       :url_f=>"https://www.century1chevy.com",
       :url_path=>nil,
       :web_neg=>nil,
       :verified_url=>"http://www.centurychevy.com",
       :url_redirected=>true,
       :response_code=>"405",
       :url_sts=>"Valid",
       :url_date=>'rspec_time',
       :wx_date=>nil,
       :timeout=>0}
    end

    it 'check_for_redirect' do
      expect(run_obj.check_for_redirect(url_hash_in)).to eql(url_hash_out)
    end
  end


  describe '#send_to_curl' do
    let(:url_hash_in) do
      {:web_status=>"unchanged",
       :url=>"https://www.century1chevy.com",
       :url_f=>"https://www.century1chevy.com",
       :url_path=>nil,
       :web_neg=>nil,
       :verified_url=>nil,
       :url_redirected=>false,
       :response_code=>nil,
       :url_sts=>nil,
       :url_date=>'rspec_time',
       :wx_date=>nil,
       :timeout=>0}
    end

    let(:url_hash_out) do
      {:web_status=>"unchanged",
       :url=>"https://www.century1chevy.com",
       :url_f=>"https://www.century1chevy.com",
       :url_path=>nil,
       :web_neg=>nil,
       :verified_url=>"http://www.centurychevy.com",
       :url_redirected=>false,
       :response_code=>"405",
       :url_sts=>"Valid",
       :url_date=>'rspec_time',
       :wx_date=>nil,
       :timeout=>0}
    end

    it 'send_to_curl' do
      expect(run_obj.send_to_curl(url_hash_in)).to eql(url_hash_out)
    end
  end


  describe '#evaluate_curl_err' do
    let(:curl_err) { "Error: Timeout" }
    let(:output) { 60 }

    it 'evaluate_curl_err' do
      expect(run_obj.evaluate_curl_err(curl_err)).to eql(output)
    end
  end


  describe '#process_valid_curl_response' do
    let(:url_hash_in) do
      {:web_status=>"unchanged",
       :url=>"https://www.century1chevy.com",
       :url_f=>"https://www.century1chevy.com",
       :url_path=>nil,
       :web_neg=>nil,
       :verified_url=>nil,
       :url_redirected=>false,
       :response_code=>nil,
       :url_sts=>nil,
       :url_date=>'rspec_time',
       :wx_date=>nil,
       :timeout=>0}
    end

    let(:curl_result) do
      {:verified_url=>"http://www.centurychevy.com", :response_code=>"405", :curl_err=>nil}
    end

    let(:url_hash_out) do
      {:web_status=>"unchanged",
       :url=>"https://www.century1chevy.com",
       :url_f=>"https://www.century1chevy.com",
       :url_path=>nil,
       :web_neg=>nil,
       :verified_url=>"http://www.centurychevy.com",
       :url_redirected=>false,
       :response_code=>"405",
       :url_sts=>"Valid",
       :url_date=>'rspec_time',
       :wx_date=>nil,
       :timeout=>0}
    end

    it 'process_valid_curl_response' do
      expect(run_obj.process_valid_curl_response(url_hash_in, curl_result)).to eql(url_hash_out)
    end
  end



end
