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
module Ixtlan
  module Configuration
    class Configuration

      include DataMapper::Resource

      def self.storage_name(arg)
        'ixtlan_configuration'
      end

      property :id, Serial

      if defined? Ixtlan::Session
        property :idle_session_timeout, Integer, :required => true, :default => 15
      end

      if defined? Ixtlan::Audit
        property :audits_keep_logs, Integer, :required => true, :default => 30
      end

      if defined? Ixtlan::Errors
        property :errors_keep_dumps, Integer, :required => true, :default => 30
        property :errors_base_url, String, :required => false, :length => 128, :default => "http://localhost:3000/errors" 
        property :errors_from_email, String, :required => false, :length => 128, :default => 'no-reply@example.com'
        property :errors_to_emails, String, :required => false, :length => 255, :default => 'developer@example.com'
      end

      if defined? Ixtlan::Remote
        property :users_url, String, :required => false, :length => 128, :default => "http://localhost:3000" 
        property :users_token, String, :required => true, :length => 64, :default => "behappy"
      end

      if defined? Ixtlan::Gettext
        property :flash_url, String, :required => false, :length => 128, :default => "http://localhost:3000" 
        property :translations_url, String, :required => false, :length => 128, :default => "http://localhost:3000" 
        property :translations_token, String, :required => true, :length => 64, :default => "be happy"
      end

      timestamps :at

      if defined?( ::User ) && ::User.respond_to?( :properties ) # DataMapper
        belongs_to :modified_by, ::User
      elsif defined?( Ixtlan::UserManagement::User ) && Ixtlan::UserManagement::User.respond_to?( :properties ) # DataMapper
        belongs_to :modified_by, Ixtlan::UserManagement::User
      end

      def to_s
        "Configuration( #{updated_at} by #{modified_by} )"
      end

      def self.instance
        self.first || self.new
      end

    end
  end
end