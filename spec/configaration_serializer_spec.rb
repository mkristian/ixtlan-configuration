# -*- coding: utf-8 -*-
require File.expand_path( File.join( File.dirname( __FILE__ ),
                                     'spec_helper.rb' ) )

require 'ixtlan/configuration/resource'
require 'ixtlan/configuration/serializer'
require 'ixtlan/configuration/filter'
require 'ixtlan/babel/factory'

describe Ixtlan::Configuration::Configuration do

  subject do
    c = Ixtlan::Configuration::Configuration.instance
    c.modified_by = root
    c.save
    c
  end

  let( :root ) do
    unless u = Ixtlan::UserManagement::User.first
      u = Ixtlan::UserManagement::User.create( :login => 'root',
                                               :name => 'Root',
                                               :updated_at => DateTime.now )
    end
    u
  end

  let( :factory ) { Ixtlan::Babel::Factory.new }

  it 'serializes' do
    expected = {
      "base_url"=>"http://localhost:3000",
      "audit_keep_logs"=>30,
      "errors_keep_dumps"=>30,
      "errors_base_path"=>"/errors",
      "errors_from_email"=>"no-reply@example.com",
      "errors_to_emails"=>"developer@example.com",
      "modified_by"=>{
        "id"=>1,
        "login"=>"root",
        "name"=>"Root"
      }
    }
    result = factory.new_serializer( subject ).to_hash
    result.delete("created_at").wont_be_nil
    result.delete("updated_at").wont_be_nil
    result.must_equal expected
  end

  it 'filters' do
    expected = {
      "base_url"=>"http://localhost:3000",
      "audit_keep_logs"=>30,
      "errors_keep_dumps"=>30,
      "errors_base_path"=>"/errors",
      "errors_from_email"=>"no-reply@example.com",
      "errors_to_emails"=>"developer@example.com"
    }
    json = factory.new_serializer( subject ).to_hash
    result = factory.new_filter( subject.class ).filter_it( json ).to_hash
    result[ :params ].must_equal expected
    result[ 'updated_at' ].sub( /\..*$/, '').must_equal subject.updated_at.to_s.sub( /\+.*$/, '')
  end
end
