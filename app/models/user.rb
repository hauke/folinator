# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: users
#
#  id           :integer         not null, primary key
#  identity_url :string(255)
#  email        :string(255)
#  name         :string(255)
#  admin        :boolean
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

class OnlyTziOpenID < ActiveModel::Validator
  def validate(record)
    if (record.identity_url =~ /^https:\/\/openid.tzi.de\//) != 0
      record.errors[:base] << "Only users from https://openid.tzi.de allowed"
    end
  end
end

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :openid_authenticatable

  has_many :annotations, foreign_key: "last_author_id"

  validates_with OnlyTziOpenID

  attr_accessible :identity_url

  def self.build_from_identity_url(identity_url)
    User.new(identity_url: identity_url)
  end
  
  def self.openid_optional_fields
    %w(
      http://openid.tzi.de/spec/schema/displayName
      http://openid.tzi.de/spec/schema/mail
    )
  end
  
  def openid_fields=(fields)
    logger.debug fields

    fields.each do |key, value|
      # Some AX providers can return multiple values per key
      if value.is_a? Array
        value = value.first
      end

      case key.to_s
        when 'http://openid.tzi.de/spec/schema/displayName'
          self.name = value
        when 'http://openid.tzi.de/spec/schema/mail'
          self.email = value
        else
          logger.error "Unknown OpenID field: #{key}"
      end
    end
  end

  def identifier
    user_match = identity_url.match(/^https:\/\/openid.tzi.de\/(.*)/)
    return user_match[1] if user_match.length == 2
    identity_url
  end

  def username
    return name if name
    return identifier
  end
end
