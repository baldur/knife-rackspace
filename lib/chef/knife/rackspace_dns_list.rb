require 'chef/knife/rackspace_base'

class Chef
  class Knife
    class RackspaceDnsList < Knife

      include Knife::RackspaceBase

      banner "knife rackspace dns list (options)"

      def dns_connection
        ::Fog::DNS.new(connection_params)
      end

      def run
        server_list = [
          ui.color("domain", :bold),
          ui.color("ID", :bold),
          ui.color("Name", :bold),
          ui.color("Value", :bold),
          ui.color("TTL", :bold),
          ui.color("Type", :bold),
          ui.color("Created", :bold),
        ]
        output_column_count = server_list.length
        dns_connection.zones.each do |zone|
          domain = zone.domain
          zone.records.each do |rec|
            server_list << ui.color(domain, :green)
            server_list << rec.id
            server_list << rec.name.gsub(".#{domain}", "")
            server_list << rec.value
            server_list << rec.ttl.to_s
            server_list << rec.type
            server_list << rec.created
          end
          puts ui.list(server_list, :uneven_columns_across, output_column_count)
        end
      end
    end
  end
end
