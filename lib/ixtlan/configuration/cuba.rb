#
# Copyright (C) 2013 Christian Meier
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
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
          updated_at = keeps( Configuration )[ 'updated_at' ]
          config = Configuration.optimistic_get!( updated_at,
                                                  Configuration.instance.id )
          config.attributes = params
          config.modified_by = current_user if config.dirty?
          config.save
          write config
        end
      end
    end
  end
end
