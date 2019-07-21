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
      #puts env
      #return unless @routes.include?(env["PATH_INFO"])
      rack_input = env["rack.input"].read
      params = Rack::Utils.parse_query(rack_input, "&")
      params.each do |key, value|
        params[key] = value.gsub('ي','ی').gsub('ك', 'ک')
      end
      env["rack.input"] = StringIO.new(Rack::Utils.build_query(params))
    rescue
    ensure
      env["rack.input"].rewind
    end
end
