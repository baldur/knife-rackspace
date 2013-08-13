require 'chef/knife/rackspace_base'

class Chef
  class Knife
    class RackspaceDnsDelete < Knife

      include Knife::RackspaceBase

      banner "knife rackspace dns delete FQDN (options)"

      def dns_connection
        ::Fog::DNS.new(connection_params)
      end
      
      def run
        domain = @name_args.first.split(".")[1..-1].join(".")
        zone = dns_connection.zones.detect {|x| x.domain == domain }
        rec = zone.records.detect {|x| x.name == domain }
        rec.destroy
      end
    end
  end
end
