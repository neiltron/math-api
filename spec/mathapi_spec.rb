require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

API_ROOT = 'http://mathurl.com'
ACCESSKEY = 123
USER_ID = 456

describe Math::API do

  FakeWeb.register_uri(:get, "#{API_ROOT}/api/1/users/profile.json?accesskey=FALSEKEY", :status => ["401", "Unauthorized"])

  it "throws an error if not authenticated" do

    begin
      Math::API.new( accesskey: 'FALSEKEY', user_id: 'FALSEUSERID', math_url: API_ROOT )
    rescue Math::API::Error => e
      true
    end

    false

  end


  describe "create_records" do

    before(:all) do
      FakeWeb.clean_registry

      FakeWeb.register_uri(:get, "#{API_ROOT}/api/1/users/profile.json", :status => ["200"])
      FakeWeb.register_uri(:post, "#{API_ROOT}/api/1/users/#{USER_ID}/records.json", :status => ["201"])

      @api = Math::API.new( accesskey: ACCESSKEY, user_id: USER_ID, math_url: API_ROOT )
    end


    it "returns a response after creating records" do

      resp = @api.create_records({ timestamp: "12/12/2012", item_name: "item", amount: "1" })

      resp.code.should == 201

    end


    it 'throws an error if item_name is not specified' do

      expect do

        @api.create_records({ timestamp: "12/12/2012", amount: "1" })

      end.to raise_error(ArgumentError)

    end


    it 'throws an error if amount is not specified' do

      expect do

        @api.create_records({ timestamp: "12/12/2012", item_name: "item" })

      end.to raise_error(ArgumentError)

    end

  end
end