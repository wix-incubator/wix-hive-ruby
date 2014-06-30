module Wix
  module Hive
    module Client

      class Groups

        include Wix::APIOperations::Create
        include Wix::APIOperations::Delete
        #include Wix::APIOperations::Update
        include Wix::APIOperations::List

        @@prototype = WixAPICaller.new

        # TODO This should be erased and 'List'/'all' should be used instead
        def get_groups (cursor)
          request = create_request('GET', '/v1/groups')
          if cursor != nil
            request.with_query_param('cursor', cursor)
          end
          wixApi = self
          resource_request(request, lambda do |data|
            WixPagingData.new(data, lambda do |cursor|
              wixApi.get_contacts(cursor)
            end )
          end )
        end

        private

        def group_url
          url + '/groups'
        end

        # TODO see and copy 'retrieve' function behaviour
        def get_group_by_id (contact_id)
          url + '/groups/' + contact_id
        end

      end

    end
  end
end