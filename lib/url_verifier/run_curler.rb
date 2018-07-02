
module UrlVerifier
  class RunCurler

    def initialize(args={})
      @timeout_limit = args.fetch(:timeout_limit, 60)
      @web_formatter = CrmFormatter::Web.new
      @curler = UrlVerifier::Curler.new

      # @dj_on = false
      # @dj_count_limit = 0
      # @dj_workers = 3
      # @obj_in_grp = 10
      # @dj_refresh_interval = 10
      # @cut_off = 10.days.ago
      # @current_process = "VerUrl"
      # @url_hash = {}
    end

    def verify_urls(urls=[])
      url_hashes = urls.map { |url| verify_url(url) }
    end

    def verify_url(url)
      url_hash = @web_formatter.format_url(url)
      url_hash = merge_url_hash(url_hash)

      if url_hash[:url_f].present?
        url_hash = send_to_curl(url_hash)
        url_hash = check_for_redirect(url_hash)
      else
        url_hash = evaluate_formatted_url(url_hash)
      end

      puts url_hash.inspect
      url_hash
    end

    def merge_url_hash(url_hash)
      url_hash_fields = {
        verified_url: nil,
        url_redirected: false,
        response_code: nil,
        url_sts: nil,
        url_date: Time.now,
        wx_date: nil,
        timeout: 0
      }
      url_hash.merge(url_hash_fields)
    end

    def evaluate_formatted_url(url_hash)
      url_hash = url_hash.merge({url_sts: 'Invalid', wx_date: Time.now })
    end

    def check_for_redirect(url_hash)
      ver = url_hash[:verified_url]
      form = url_hash[:url_f]
      url_hash[:url_redirected] = ver.present? && ver != form
      url_hash
    end

    def send_to_curl(url_hash)
      curl_result = @curler.start_curl(url_hash[:url_f], @timeout_limit)
      curl_err = curl_result[:curl_err]

      if curl_err.present?
        url_hash = url_hash.merge({ url_sts: curl_err, timeout: evaluate_curl_err(curl_err) })
      else
        url_hash = process_valid_curl_response(url_hash, curl_result)
      end

      url_hash
    end

    def evaluate_curl_err(curl_err)
      curl_err == "Error: Timeout" || curl_err == "Error: Host" ? timeout = @timeout_limit : timeout = 0
    end

    def process_valid_curl_response(url_hash, curl_result)
      curl_result[:verified_url].present? ? url_sts = 'Valid' : url_sts = "Error: Nil"

      valid_hash = {
        verified_url: curl_result[:verified_url],
        url_sts: url_sts,
        response_code: curl_result[:response_code],
        timeout: 0
      }
      url_hash = url_hash.merge(valid_hash)
    end


    ##### ADVANCED USAGE - REVISIT LATER #####
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

    # def template_starter(url)
      # web = Web.find(id)
      # web_url = web.url
      # db_timeout = web.timeout
      # db_timeout == 0 ? timeout = @dj_refresh_interval : timeout = (db_timeout * 3)
    # end

  end

end
