require 'hive/site'

module Hive
  module REST
    module Sites
      include Hive::Util

      def sites_site(query_options = {})
        perform_with_object(:get, 'v1/sites/site', Hive::Site, params: query_options)
      end

      def sites_site_pages(query_options = {})
        perform_with_object(:get, 'v1/sites/site/pages', Hive::SitePages, params: query_options)
      end
    end
  end
end
