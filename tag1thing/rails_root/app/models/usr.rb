class Usr < ActiveRecord::Base
  has_many :cmmnts
  has_many :iimgs
  has_many :srchs
  has_many :tags
  has_many :thngs
  has_many :uurls
  has_many :videos
end
