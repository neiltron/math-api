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

      FakeWeb.register_uri(:get, "#{API_ROOT}/api/1/users/profile.json?accesskey=#{ACCESSKEY}", :status => ["200"])
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


  describe "get_records" do

    before(:all) do
      FakeWeb.clean_registry

      FakeWeb.register_uri(:get, "#{API_ROOT}/api/1/users/profile.json?accesskey=#{ACCESSKEY}", :status => ["200"])
      FakeWeb.register_uri(:get, "#{API_ROOT}/api/1/users/#{USER_ID}/items/totallyrealitemid/records.json", :body => File.read(File.join(File.dirname(__FILE__), "fixtures", "records_page1.json")), :content_type => 'application/json')
      FakeWeb.register_uri(:get, "#{API_ROOT}/api/1/users/#{USER_ID}/items/totallyrealitemid/records.json?page=2", :body  => File.read(File.join(File.dirname(__FILE__), "fixtures", "records_page2.json")), :content_type => 'application/json')
      FakeWeb.register_uri(:get, "#{API_ROOT}/api/1/users/#{USER_ID}/items/totallyrealitemid/records.json?per_page=10", :body => File.read(File.join(File.dirname(__FILE__), "fixtures", "records_perpage.json")), :content_type => 'application/json')

      @api = Math::API.new( accesskey: ACCESSKEY, user_id: USER_ID, math_url: API_ROOT )
    end

    it "returns an argumenterror if no item_id is specified" do

      expect{ @api.get_records }.to raise_error(ArgumentError)

    end

    it "returns a set of records" do

      @page1 = @api.get_records({ item_id: 'totallyrealitemid' })
      @page1.values[0].count.should == 33

    end

    it "returns a different set of records" do

      @page2 = @api.get_records({ item_id: 'totallyrealitemid', page: 2 })
      @page2.values[0].should_not == @page1

    end

    it "returns a different amount of records using per_page" do

      records = @api.get_records({ item_id: 'totallyrealitemid', per_page: 10 })
      records.values[0].count.should == 10

    end

  end

end