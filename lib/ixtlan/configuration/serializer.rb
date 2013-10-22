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
require 'ixtlan/babel/serializer'

class ConfigurationSerializer < Ixtlan::Babel::Serializer

  METHODS = [ :base_url, :created_at, :updated_at ]
  
  if defined? Ixtlan::Session
    METHODS << :idle_session_timeout
  end

  if defined? Ixtlan::Audit
    METHODS << :audit_keep_logs
  end

  if defined? Ixtlan::Errors
    METHODS << :errors_keep_dumps
    METHODS << :errors_base_path
    METHODS << :errors_from_email
    METHODS << :errors_to_emails
  end

  if defined? Ixtlan::Remote
    METHODS << :users_url 
    METHODS << :users_token
  end

  if defined? Rack::Session::EncryptedCookie
    METHODS << :encrypted_cookie_secret
  end

  if defined? Ixtlan::Gettext
    METHODS << :flash_url 
    METHODS << :translations_url 
    METHODS << :translations_token
  end

  if defined?( Ixtlan::UserManagement::User ) && Ixtlan::UserManagement::User.respond_to?( :properties )
    add_context(:single,
                :only => [],
                :methods => METHODS,
                :include => {
                  :modified_by => {
                    :only => [],
                    :methods => [:id, :login, :name]
                  }
                }
                )
  else
    add_context(:single,
                :only => [],
                :methods => METHODS
                )
  end
end
