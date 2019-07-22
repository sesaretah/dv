class Scrubber
  def initialize(app, options)
    @app = app
    @routes = options[:routes]
  end

  def call(env)
    scrub(env)
    @app.call(env)
  end

  private
    def scrub(env)
      return unless env["CONTENT_TYPE"] == "application/x-www-form-urlencoded"
      rack_input = env["rack.input"].read
      params = Rack::Utils.parse_query(rack_input, "&")
      params.each do |key, value|
      if key != 'authenticity_token'
        params[key] = value.gsub('ي','ی').gsub('ك', 'ک')
      end
      end
      env["rack.input"] = StringIO.new(Rack::Utils.build_query(params))
    rescue
    ensure
      env["rack.input"].rewind
    end
end
