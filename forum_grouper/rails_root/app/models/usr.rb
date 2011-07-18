require 'digest/sha1'

# this model expects a certain database layout and its based on the name/login pattern.
class Usr < ActiveRecord::Base
  CHANGEABLE_FIELDS = ['first_name', 'last_name', 'email']
  attr_accessor :password_needs_confirmation

  after_save '@password_needs_confirmation = false'
  after_validation :crypt_password

  validates_presence_of :login, :on => :create
  validates_length_of :login, :within => 3..40, :on => :create
  validates_uniqueness_of :login, :on => :create
  validates_uniqueness_of :email, :on => :create

  validates_presence_of :password, :if => :validate_password?
  validates_confirmation_of :password, :if => :validate_password?
  validates_length_of :password, { :minimum => 5, :if => :validate_password? }
  validates_length_of :password, { :maximum => 40, :if => :validate_password? }

  def initialize(attributes = nil)
    super
    @password_needs_confirmation = false
  end

  def self.authenticate(login, pass)
    u = find( :first, :conditions => ["login = ? AND verified = TRUE AND deleted = FALSE", login])
    return nil if u.nil?
    find( :first, :conditions => ["login = ? AND salted_password = ? AND verified = TRUE", login, salted_password(u.salt, hashed(pass))])
  end

  def self.authenticate_by_token(id, token)
    # Allow logins for deleted accounts, but only via this method (and
    # not the regular authenticate call)
    logger.info "Attempting authorization of #{id} with #{token}"
    u = find( :first, :conditions => ["id = ? AND security_token = ?", id, token])
    if u
      logger.info "Authenticated by token: #{u.inspect}"
    else
      logger.info "Not authenticated" if u.nil?
    end
    return nil if (u.nil? or u.token_expired?)
    u.update_attributes :verified => true, :token_expiry => Clock.now
    return u
  end

  def token_expired?
    self.security_token and self.token_expiry and (Clock.now >= self.token_expiry)
  end

  def generate_security_token
    if self.security_token.nil? or self.token_expiry.nil? or (Clock.now.to_i + token_lifetime / 2) >= self.token_expiry.to_i
      token = new_security_token
      return token
    else
      return self.security_token
    end
  end

  def change_password(pass, confirm = nil)
    self.password = pass
    self.password_confirmation = confirm.nil? ? pass : confirm
    @password_needs_confirmation = true
  end

  def token_lifetime
    UsrSystem::CONFIG[:security_token_life_hours] * 60 * 60
  end

  # Help Active Scaffold display Usr objects.
  # ref: http://activescaffold.com/tutorials/to_label
  def to_label
    login
  end

  protected

  attr_accessor :password, :password_confirmation

  def validate_password?
    @password_needs_confirmation
  end

  def self.hashed(str)
    return Digest::SHA1.hexdigest("change-me--#{str}--")[0..39]
  end

  def crypt_password
    if @password_needs_confirmation
      write_attribute("salt", self.class.hashed("salt-#{Clock.now}"))
      write_attribute("salted_password", self.class.salted_password(salt, self.class.hashed(@password)))
    end
  end

  def new_security_token
    expiry = Time.at(Clock.now.to_i + token_lifetime)
    write_attribute('security_token', self.class.hashed(self.salted_password + Clock.now.to_i.to_s + rand.to_s))
    write_attribute('token_expiry', expiry)
    update_without_callbacks
    return self.security_token
  end

  def self.salted_password(salt, hashed_password)
    hashed(salt + hashed_password)
  end
end

