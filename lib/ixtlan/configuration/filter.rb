require 'ixtlan/babel/params_filter'
module Ixtlan
  module Configuration
    class ConfigurationFilter < Ixtlan::Babel::ParamsFilter

      root 'configuration'

      add_context( :single,
                   :keep => [ :updated_at ],
                   :except => [:id, :created_at, :updated_at, :modified_by_id] )

    end
  end
end
