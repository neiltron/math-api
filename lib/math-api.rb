require 'httparty'

module Math
  class API

    VERSION = "0.0.2"

    include HTTParty
    format :json

    attr_accessor :base_url, :accesskey, :user_id


    def initialize ( opts = { } )

      self.class.base_uri    opts[:math_url] || 'http://math.dev'
      self.accesskey      =  opts[:accesskey]
      self.user_id        =  opts[:user_id]

      self.authenticate

    end


    def authenticate
      resp = self.class.get('/api/1/users/profile.json', { accesskey: @accesskey })

      raise Error.new("Unauthorized") unless resp.code == 200
    end


    def create_records (data)

      raise ArgumentError, "Must specify an item_name" if data[:item_name].nil?
      raise ArgumentError, "Must specify an amount" if data[:amount].nil?


      data = data.merge({ accesskey: @accesskey })

      self.class.post("/api/1/users/#{@user_id.to_s}/records.json", body: data )

    end

  end

  class API::Error < ::StandardError; end
end
