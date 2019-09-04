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
         c = Open3.capture3("echo '#{value}' | sed -e 's/[ﺀﺁﺂﺃﺄﺅﺆﺇﺈﺉﺊﺋﺌﺍﺎ]/ا/g;' -e 's/[ﺏﺐﺑﺒ]/ب/g;' -e 's/[ﺓﺔ]/ه/g;' -e 's/[ﺕﺖﺗﺘ]/ت/g;' -e 's/[ﺙﺚﺛﺜ]/ث/g;' -e 's/[ﺝﺞﺟﺠ]/ج/g;' -e 's/[ﺡﺢﺣﺤ]/ح/g;' -e 's/[ﺥﺦﺧﺨ]/خ/g;' -e 's/[ﺩﺪ]/د/g;' -e 's/[ﺫﺬ]/ذ/g;' -e 's/[ﺭﺮ]/ر/g;' -e 's/[ﺯﺰ]/ز/g;' -e 's/[ﺱﺲﺳﺴ]/س/g;' -e 's/[ﺵﺶﺷﺸ]/ش/g;' -e 's/[ﺹﺺﺻﺼ]/ص/g;' -e 's/[ﺽﺾﺿﻀ]/ض/g;' -e 's/[ﻁﻂﻃﻄ]/ط/g;' -e 's/[ﻅﻆﻇﻈ]/ظ/g;' -e 's/[ﻉﻊﻋﻌ]/ع/g;' -e 's/[ﻍﻎﻏﻐ]/غ/g;' -e 's/[ﻑﻒﻓﻔ]/ف/g;' -e 's/[ﻕﻖﻗﻘ]/ق/g;' -e 's/[ﻙﻚﻛﻜ]/ك/g;' -e 's/[ﻝﻞﻟﻠ]/ل/g;' -e 's/[ﻡﻢﻣﻤ]/م/g;' -e 's/[ﻥﻦﻧﻨ]/ن/g;' -e 's/[ﻩﻪﻫﻬ]/ه/g;' -e 's/[ﻭﻮ]/و/g;' -e 's/[ﯿییﻯﻰﻱيﻲﻳﻴ]/ي/g;' -e 's/[ﻵﻶﻷﻸﻹﻺﻻﻼ]/لا/g;' -e 's/[ﮕ]/گ/g;' -e 's/[ﺉﺊﺋﺌ]/ئ/g;'")
         params[key] = c[0]#.decode('utf-8')
      end
      end
      env["rack.input"] = StringIO.new(Rack::Utils.build_query(params))
    rescue
    ensure
      env["rack.input"].rewind
    end
end
