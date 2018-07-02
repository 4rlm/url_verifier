# UrlVerifier

[![Build Status](https://travis-ci.org/4rlm/url_verifier.svg?branch=master)](https://travis-ci.org/4rlm/url_verifier)
[![Gem Version](https://badge.fury.io/rb/url_verifier.svg)](https://badge.fury.io/rb/url_verifier)
[![MIT License](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)


### Format, Verify & Follow URL redirects with detailed reports.

Following url redirects can sometimes take a few minutes and often creates various exceptions.  UrlVerifier is built with exceptional error handling, reformatting, and optional time limits you can set; default is set to 60 sec limit, but typically only takes 5-10 seconds per url.  UrlVerifier has been developed and improved upon for several years in an enterprise level app and is now available as an open source gem.  It is perfect for high-volume, yet smooth, uninterrupted url formatting and verification.

Example:

```
{
  url: 'blackwellford.com/staff',
  verified_url: 'https://www.blackwellford.com',
  url_path: '/staff',
  response_code:'200',
  url_redirected: true,
  url_sts: 'Valid'
}
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'url_verifier'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install url_verifier

## Usage

### Available Methods

#### 1. Verify one URL as a string:

```
verifier = UrlVerifier::RunCurler.new
verified_url_hashes = verifier.verify_urls(array_of_urls)
```


#### 2. Verify Array of URL strings:

```
verifier = UrlVerifier::RunCurler.new
verified_url_hashes = verifier.verify_url('example.com')
```


### Usage Example

```
array_of_urls = %w[blackwellford.com/staff www.mccrea.subaru.com/inventory www.sofake.sofake https://www.century1chevy.com https://www.mccreasubaru.com]

args = { timeout_limit: 30 }
verifier = UrlVerifier::RunCurler.new(args)
verified_url_hashes = verifier.verify_urls(array_of_urls)
```
Note: `:timeout_limit` default is 60 seconds per url, but most urls take under 10 sec each.  You can override the default by passing in your desired limit.  If 60 seconds is fine, no need to pass any args.  You could simply instantiate like this:

```
verifier = UrlVerifier::RunCurler.new
verified_url_hashes = verifier.verify_urls(array_of_urls)
```

Returns Data in Hash Format with detailed report:

Notice the URLs in the input array above were NOT uniformly formatted.  UrlVerifier leverages the `utf8_sanitizer gem` and `crm_formatter gem` to pre-format the URLs before verifying, so the results will be uniformly formatted, like in the hashes below `:url_f`.  

`:verified_url` is the final verified URL.  `:url_redirected` indicates that the verified URL is different than `:url_f`.  

If `url_sts: 'Invalid'`, `:wx_date` will be timestamped, which helps keep track of when it became invalid, incase you are running period database URL verifications and want to include these details in your reports.

`:response_code` in the 200's is ideal.  If it has recently been forwarded it will be in the 300's, and 400's indicates an issue with the URL domain or server.  Some 400's could be run later when they resolve their issues, so don't always give up on them.  

Here is a reference guide: [List of HTTP status codes](https://en.wikipedia.org/wiki/List_of_HTTP_status_codes)

```
verified_url_hashes = [
  {
    :web_status=>"formatted",
    :url=>"blackwellford.com/staff",
    :url_f=>"http://www.blackwellford.com",
    :url_path=>"/staff",
    :web_neg=>nil,
    :verified_url=>"https://www.blackwellford.com",
    :url_redirected=>true,
    :response_code=>"200",
    :url_sts=>"Valid",
    :url_date=>2018-07-02 09:16:19 -0500,
    :wx_date=>nil,
    :timeout=>0
  },
  {
    :web_status=>"formatted",
    :url=>"www.mccrea.subaru.com/inventory",
    :url_f=>"http://www.mccrea.subaru.com",
    :url_path=>nil,
    :web_neg=>nil,
    :verified_url=>"https://www.mccreasubaru.com",
    :url_redirected=>true,
    :response_code=>"200",
    :url_sts=>"Valid",
    :url_date=>2018-07-02 09:16:38 -0500,
    :wx_date=>nil,
    :timeout=>0
  },
  {
    :web_status=>"invalid",
    :url=>"www.sofake.sofake",
    :url_f=>nil,
    :url_path=>nil,
    :web_neg=>"error: ext.invalid [sofake]",
    :verified_url=>nil,
    :url_redirected=>false,
    :response_code=>nil,
    :url_sts=>"Invalid",
    :url_date=>2018-07-02 09:16:58 -0500,
    :wx_date=>2018-07-02 09:16:58 -0500,
    :timeout=>nil
  },
  {
    :web_status=>"unchanged",
    :url=>"https://www.century1chevy.com",
    :url_f=>"https://www.century1chevy.com",
    :url_path=>nil,
    :web_neg=>nil,
    :verified_url=>"http://www.centurychevy.com",
    :url_redirected=>true,
    :response_code=>"405",
    :url_sts=>"Valid",
    :url_date=>2018-07-02 09:16:58 -0500,
    :wx_date=>nil,
    :timeout=>0
  },
  {
    :web_status=>"unchanged",
    :url=>"https://www.mccreasubaru.com",
    :url_f=>"https://www.mccreasubaru.com",
    :url_path=>nil,
    :web_neg=>nil,
    :verified_url=>"https://www.mccreasubaru.com",
    :url_redirected=>false,
    :response_code=>"200",
    :url_sts=>"Valid",
    :url_date=>2018-07-02 09:16:59 -0500,
    :wx_date=>nil,
    :timeout=>0
  }
]
```

## Author

Adam J Booth  - [4rlm](https://github.com/4rlm)


## Development

After checking out the repo, verify `bin/setup` to install dependencies. Then, verify `rake spec` to verify the tests. You can also verify `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, verify `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then verify `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/4rlm/url_verifier. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the UrlVerifier project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/4rlm/url_verifier/blob/master/CODE_OF_CONDUCT.md).
