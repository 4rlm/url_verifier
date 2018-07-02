# require 'check_int'
# require 'timeout'
# require 'net/ping'
# gem 'net-ping', '~> 1.7', '>= 1.7.8'
# gem 'curb', '~> 0.9.3'


module UrlVerifier
  class Curler

    def initialize
      @web_formatter = CrmFormatter::Web.new
    end

    def start_curl(url, timeout)
      curl_result = { verified_url: nil, response_code: nil, curl_err: nil }
      if url.present?
        result = nil

        begin # Curl Exception Handling
          begin # Timeout Exception Handling
            Timeout.timeout(timeout) do
              puts "\n\n=== WAITING FOR CURL RESPONSE ==="
              result = Curl::Easy.perform(url) do |curl|
                curl.follow_location = true
                curl.useragent = "curb"
                curl.connect_timeout = timeout
                curl.enable_cookies = true
                curl.head = true #testing - new
              end # result

              curl_result[:response_code] = result&.response_code.to_s
              web_hsh = @web_formatter.format_url(result&.last_effective_url)

              if web_hsh[:url_f].present?
                curl_result[:verified_url] = web_hsh[:url_f]
                # curl_result[:verified_url] = @web_formatter.convert_to_scheme_host(web_hsh[:url_f])
              end
            end

          rescue Timeout::Error # Timeout Exception Handling
            curl_result[:curl_err] = "Error: Timeout"
          end

        rescue LoadError => e  # Curl Exception Handling
          curl_err = error_parser("Error: #{$!.message}")
          # CheckInt.new.check_int if curl_err.include?('TCP')
          curl_result[:curl_err] = curl_err
        end
      else ## If no url present?
        curl_result[:curl_err] = 'URL Nil'
      end

      print_result(curl_result)
      curl_result
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


    def print_result(curl_result)
      "\n\n\n#{'='*30}"
      puts curl_result
      "#{'='*30}\n\n\n"
    end


  end
end
