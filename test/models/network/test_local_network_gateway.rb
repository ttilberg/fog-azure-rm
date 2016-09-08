require File.expand_path '../../test_helper', __dir__

# Test class for LocalNetworkGateway Model
class TestLocalNetworkGateway < Minitest::Test
  def setup
    @service = Fog::Network::AzureRM.new(credentials)
    @local_network_gateway = local_network_gateway(@service)
    @response = ApiStub::Models::Network::LocalNetworkGateway.create_local_network_gateway_response
  end

  def test_model_methods
    methods = [
      :save,
      :destroy
    ]
    methods.each do |method|
      assert @local_network_gateway.respond_to? method
    end
  end

  def test_model_attributes
    attributes = [
      :name,
      :id,
      :location,
      :type,
      :resource_group,
      :tags,
      :local_network_address_space_prefixes,
      :gateway_ip_address,
      :asn,
      :bgp_peering_address,
      :peer_weight,
      :provisioning_state
    ]
    attributes.each do |attribute|
      assert @local_network_gateway.respond_to? attribute
    end
  end

  def test_save_method_response
    @service.stub :create_or_update_local_network_gateway, @response do
      assert_instance_of Fog::Network::AzureRM::LocalNetworkGateway, @local_network_gateway.save
    end
  end

  def test_destroy_method_response
    @service.stub :delete_local_network_gateway, true do
      assert @local_network_gateway.destroy
    end
  end
end
