require 'cuba_api'
require 'ixtlan/configuration/resource'
require 'ixtlan/configuration/filter'
require 'ixtlan/configuration/serializer'

module Ixtlan
  module Configuration
    class Cuba < ::CubaAPI

      define do
        on get do
          write Configuration.instance
        end

        on post do
          updated_at = keeps( Configuration )[ :updated_at ]
          config = Configuration.optimistic_get!( updated_at,
                                                  Configuration.instance.id )
          config.attributes = params
          config.modified_by = current_user if config.dirty?
          config.save
          write config
        end

        # on get, :id do |id|
        #   write Configuration.get!( id )
        # end

        # on get do
        #   write Configuration.all
        # end

        # on post do
        #   config = new_instance( Configuration )
        #   config.save
        #   write config
        # end

        # on put, :id do |id|
        #   updated_at = keeps( Configuration )[ :updated_at ]
        #   config = Configuration.optimistic_get!( updated_at,
        #                                           id )
        #   config.attributes = params
        #   config.modified_by = current_user if config.dirty?
        #   config.save
        #   write config
        # end

        # on delete, :id do |id|
        #   updated_at = keeps( Configuration )[ :updated_at ]
        #   config = Configuration.optimistic_get( updated_at,
        #                                          id )
        #   config.destroy
        #   head 200
        # end

      end
    end
  end
end
