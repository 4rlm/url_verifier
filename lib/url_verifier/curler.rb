# require 'check_int'
# require 'timeout'
# require 'net/ping'
# gem 'net-ping', '~> 1.7', '>= 1.7.8'
# gem 'curb', '~> 0.9.3'

module UrlVerifier
  class Curler

    def initialize
      @web_formatter = CrmFormatter::Web.new
      @ran_again = false
    end

    def start_curl(url, timeout)
      curl_result = { verified_url: nil, response_code: nil, curl_err: nil }
      if url.present?
        result = nil

        begin # Curl Exception Handling
          begin # Timeout Exception Handling
            pre_curl_msg(url, timeout)
            Timeout.timeout(timeout) do
              result = Curl::Easy.perform(url) do |curl|
                curl.follow_location = true
                curl.useragent = "curb"
                curl.connect_timeout = timeout
                curl.enable_cookies = true
                curl.head = true #testing - new
              end # result

              curl_result[:response_code] = result&.response_code.to_s
              web_hsh = @web_formatter.format_url(result&.last_effective_url)

              url_f = web_hsh[:url_f]
              curl_result[:verified_url] = url_f if url_f.present?
            end

          rescue Timeout::Error # Timeout Exception Handling
            curl_result[:curl_err] = "Error: Timeout"
          end

        # rescue LoadError => e  # Curl Exception Handling
        rescue StandardError => e
          curl_err = error_parser("Error: #{$!.message}")
          # CheckInt.new.check_int if curl_err.include?('TCP')
          curl_result[:curl_err] = curl_err
        end
      else ## If no url present?
        curl_result[:curl_err] = 'URL Nil'
      end

      curl_result = run_again(curl_result, url, timeout)
      curl_result
    end

    def run_again(curl_result, url, timeout)
      if curl_result[:curl_err].present?
        if @ran_again == false
          @ran_again = true
          url = https_to_http(url)
          curl_result = start_curl(url, timeout)
        else
          @ran_again = false
        end
      else
        @ran_again = false
      end
      curl_result
    end

    def https_to_http(url)
      url = url.gsub('https://', 'http://')
    end

    def pre_curl_msg(url, timeout)
      msg = "\n\n#{'='*40}\nVERIFYING: #{url}\nMax Wait Set: #{timeout} Seconds\n\n"
      puts msg
      msg
    end

    def error_parser(curl_err)
      if curl_err.include?("Couldn't connect to server")
        curl_err = "Error: Expired Url"
      elsif curl_err.include?("SSL connect error")
        curl_err = "Error: SSL"
      elsif curl_err.include?("Couldn't resolve host name")
        curl_err = "Error: Host"
      elsif curl_err.include?("Peer certificate")
        curl_err = "Error: Certificate"
      elsif curl_err.include?("Failure when receiving data")
        curl_err = "Error: Transfer"
      elsif curl_err.include?("TCP connection")
        curl_err = "Error: TCP"
      else
        curl_err = "Error: Undefined"
      end
      curl_err
    end

  end
end
