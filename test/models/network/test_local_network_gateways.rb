require File.expand_path '../../test_helper', __dir__

# Test class for LocalNetworkGateway Collection
class TestLocalNetworkGateways < Minitest::Test
  def setup
    @service = Fog::Network::AzureRM.new(credentials)
    @local_network_gateways = Fog::Network::AzureRM::LocalNetworkGateways.new(resource_group: 'fog-rg', service: @service)
    @network_client = @service.instance_variable_get(:@network_client)
  end

  def test_collection_methods
    methods = [
      :all,
      :get
    ]
    methods.each do |method|
      assert @local_network_gateways.respond_to? method
    end
  end

  def test_collection_attributes
    assert @local_network_gateways.respond_to? :resource_group
  end

  def test_all_method_response
    response = [ApiStub::Models::Network::LocalNetworkGateway.create_local_network_gateway_response]
    @service.stub :list_local_network_gateways, response do
      assert_instance_of Fog::Network::AzureRM::LocalNetworkGateways, @local_network_gateways.all
      assert @local_network_gateways.all.size >= 1
      @local_network_gateways.all.each do |local_network_gateway|
        assert_instance_of Fog::Network::AzureRM::LocalNetworkGateway, local_network_gateway
      end
    end
  end

  def test_get_method_response
    response = ApiStub::Models::Network::LocalNetworkGateway.create_local_network_gateway_response
    @service.stub :get_local_network_gateway, response do
      assert_instance_of Fog::Network::AzureRM::LocalNetworkGateway, @local_network_gateways.get('fog-rg', 'mylocalgateway1')
    end
  end
end
