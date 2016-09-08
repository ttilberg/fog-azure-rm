module Fog
  module Network
    class AzureRM
      # Real class for Network Request
      class Real
        def list_local_network_gateways(resource_group_name)
          msg = "Getting list of Local Network Gateway from Resource Group #{resource_group_name}."
          Fog::Logger.debug msg
          begin
            local_network_gateways = @network_client.local_network_gateways.list_as_lazy(resource_group_name)
          rescue MsRestAzure::AzureOperationError => e
            raise_azure_exception(e, msg)
          end
          local_network_gateways.value
        end
      end

      # Mock class for Network Request
      class Mock
        def list_virtual_network_gateways(*)
          local_network_gateway = Azure::ARM::Network::Models::LocalNetworkGateway.new
          local_network_gateway.id = '/subscriptions/<Subscription_id>/resourceGroups/learn_fog/providers/Microsoft.Network/localNetworkGateways/testLocalNetworkGateway'
          local_network_gateway.name = 'testLocalNetworkGateway'
          local_network_gateway.type = 'Microsoft.Network/localNetworkGateways'
          local_network_gateway.location = 'eastus'
          local_network_gateway.gateway_ip_address = '192.168.1.1'
          local_network_gateway.provisioning_state = 'Succeeded'
          address_space = Azure::ARM::Network::Models::AddressSpace.new
          address_space.address_prefixes = []
          local_network_gateway.local_network_address_space = address_space
          bgp_settings = Azure::ARM::Network::Models::BgpSettings.new
          bgp_settings.asn = 100
          bgp_settings.bgp_peering_address = '192.168.1.2'
          bgp_settings.peer_weight = 3
          local_network_gateway.bgp_settings = bgp_settings
          local_network_gateway.resource_guid = '########-####-####-####-############'

          local_network_gateway_list = Azure::ARM::Network::Models::LocalNetworkGatewayListResult.new
          local_network_gateway_object = local_network_gateway
          local_network_gateway_list.value = []
          local_network_gateway_list.value.push(local_network_gateway_object)
          local_network_gateway_list
        end
      end
    end
  end
end
