require 'curler'

module UrlVerifier
  class RunCurler
    # include Curler

    def initialize(args={})
      binding.pry
      @dj_on = false
      @dj_count_limit = 0
      @dj_workers = 3
      @obj_in_grp = 10
      @dj_refresh_interval = 10
      @timeout_limit = 60
      @cut_off = 10.days.ago
      # @formatter = Formatter.new
      # @mig = Mig.new
      @current_process = "VerUrl"
      @web_formatter = CRMFormatter::Web.new
      @curler = UrlVerifier::Curler.new
      @url_hash = {}
    end


    # def get_query
    #   err_sts_arr = ['Error: Timeout', 'Error: Host', 'Error: TCP']
    #   query = Web.select(:id)
    #     .where(url_sts: ['Valid', nil])
    #     .where('url_date < ? OR url_date IS NULL', @cut_off)
    #       .or(Web.select(:id)
    #         .where(url_sts: err_sts_arr)
    #         .where('timeout < ?', @timeout_limit)
    #       ).order("timeout ASC").pluck(:id)
    # end


    # def start_ver_url
    #   query = get_query[0..20]
    #   while query.any?
    #     setup_iterator(query)
    #     query = get_query[0..20]
    #     break unless query.any?
    #   end
    # end


    # def setup_iterator(query)
    #   @query_count = query.count
    #   (@query_count & @query_count > @obj_in_grp) ? @group_count = (@query_count / @obj_in_grp) : @group_count = 2
    #   @dj_on ? iterate_query(query) : query.each { |id| template_starter(id) }
    # end


    ##Call: StartVerify.run
    ### Accepts array of URLs ###
    def verify_urls(urls)
      binding.pry
      url_hashes = urls.map { |url| url_verifier(url) }
      binding.pry
      url_hashes
    end


    ### Accepts string URL ###
    def url_verifier(url)
      url_hash = format_url(url)
      url_hash = check_for_redirect(url_hash)
    end


    def check_for_redirect(url_hash)
      ver = url_hash[:verified_url]
      form = url_hash[:formatted_url]
      url_hash[:url_redirected] = ver.present? && ver != form
      url_hash
    end


    # #Call: StartVerify.run
    def format_url(url)
      url_hash = @web_formatter.format_url(url)
      url_hash.merge!({ verified_url: nil, url_redirected: false, response_code: nil, url_sts: nil, url_date: Time.now, wx_date: nil, timeout: nil })
      url_hash = evaluate_formatted_url(url_hash)
    end


    def evaluate_formatted_url(url_hash)
      if url_hash[:formatted_url].present?
        prepare_to_curl(url_hash)
      else
        url_hash.merge!({url_sts: 'Invalid', wx_date: Time.now })
      end
      url_hash
    end


    ####### CURL-BEGINS - FORMATTED URLS ONLY!! #######
    def prepare_to_curl(url_hash)
      curl_result = @curler.start_curl(url_hash[:formatted_url], @timeout_limit)
      curl_err = curl_result[:curl_err]
      process_valid_curl_response(url_hash, curl_result) if !curl_err.present?
      curl_err == "Error: Timeout" || curl_err == "Error: Host" ? timeout = @timeout_limit : timeout = 0
      url_hash.merge!({ url_sts: curl_err, timeout: timeout })
      url_hash
    end


    # def template_starter(url)
      # web = Web.find(id)
      # web_url = web.url
      # db_timeout = web.timeout
      # db_timeout == 0 ? timeout = @dj_refresh_interval : timeout = (db_timeout * 3)
    # end


    def process_valid_curl_response(url_hash, curl_result)
      curl_result[:verified_url].present? ? url_sts = 'Valid' : url_sts = "Error: Nil"
      url_hash.merge!( { verified_url: curl_result[:verified_url], url_sts: url_sts, response_code: curl_result[:response_code], timeout: 0 })
      url_hash
    end

  end

end
