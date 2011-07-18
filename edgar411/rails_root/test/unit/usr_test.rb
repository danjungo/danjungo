require File.dirname(__FILE__) + '/../test_helper'

class UsrTest < Test::Unit::TestCase
  fixtures :usrs
  self.use_transactional_fixtures = false

  def test_authenticate
    assert_equal usrs(:tesla), Usr.authenticate(usrs(:tesla).login, "atest")
    assert_nil Usr.authenticate("nontesla", "atest")
    assert_nil Usr.authenticate(usrs(:tesla), "wrong password")
  end

  def test_authenticate_by_token
    usr = usrs(:unverified_usr)
    assert_equal usr, Usr.authenticate_by_token(usr.id, usr.security_token)
  end

  def test_authenticate_by_token__fails_if_expired
    usr = usrs(:unverified_usr)
    Clock.time = Clock.now + 2.days
    assert_nil Usr.authenticate_by_token(usr.id, usr.security_token)
  end

  def test_authenticate_by_token__fails_if_bad_token
    usr = usrs(:unverified_usr)
    assert_nil Usr.authenticate_by_token(usr.id, 'bad_token')
  end

  def test_authenticate_by_token__fails_if_bad_id
    usr = usrs(:unverified_usr)
    assert_nil Usr.authenticate_by_token(-1, usr.security_token)
  end

  def test_change_password
    usr = usrs(:long_usr)
    usr.change_password("a new password")
    usr.save
    assert_equal usr, Usr.authenticate(usr.login, "a new password")
    assert_nil Usr.authenticate(usr.login, "alongtest")
  end

  def test_generate_security_token
    usr = Usr.new :login => 'usr', :email => 'usr@example.com', :salt => 'salt', :salted_password => 'tlas'
    usr.save
    token = usr.generate_security_token
    assert_not_nil token
    usr.reload
    assert_equal token, usr.security_token
    assert_equal (Clock.now + usr.token_lifetime).to_i, usr.token_expiry.to_i
  end

  def test_generate_security_token__reuses_token_when_not_stale
    usr = usrs(:unverified_usr)
    Clock.time = Clock.now + usr.token_lifetime/2 - 1
    assert_equal usr.security_token, usr.generate_security_token 
  end

  def test_generate_security_token__generates_new_token_when_getting_stale
    usr = usrs(:unverified_usr)
    Clock.time = Clock.now + usr.token_lifetime/2
    assert_not_equal usr.security_token, usr.generate_security_token 
  end

  def test_change_password__disallowed_passwords
    u = Usr.new
    u.login = "test_usr"
    u.email = 'disallowed_password@example.com'

    u.change_password("tiny")
    assert !u.save     
    assert u.errors.invalid?('password')

    u.change_password("hugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehuge")
    assert !u.save     
    assert u.errors.invalid?('password')
        
    u.change_password("")
    assert !u.save    
    assert u.errors.invalid?('password')
        
    u.change_password("a_s3cure_p4ssword")
    assert u.save     
    assert u.errors.empty?
  end
  
  def test_validates_login
    u = Usr.new
    u.change_password("teslas_secure_password")
    u.email = 'bad_login_tesla@example.com'

    u.login = "x"
    assert !u.save     
    assert u.errors.invalid?(:login)
    
    u.login = "hugeteslahugeteslahugeteslahugeteslahugeteslahugeteslahugeteslahugeteslahugeteslahugeteslahugeteslahugeteslahugeteslahugeteslahugeteslahugeteslahugeteslahugeteslahugeteslahugeteslahugeteslahugeteslahugeteslahugeteslahugeteslahugeteslahug"
    assert !u.save     
    assert u.errors.invalid?(:login)

    u.login = ""
    assert !u.save
    assert u.errors.invalid?(:login)

    u.login = "oktesla"
    assert u.save
    assert u.errors.empty?
      
  end

  def test_create
    u = Usr.new
    u.login = "nonexisting_usr"
    u.email = 'nonexisting_email@example.com'
    u.change_password("password")
    assert u.save
  end

  def test_create__validates_unique_login
    u = Usr.new
    u.login = usrs(:tesla).login
    u.email = 'new@example.com'
    u.change_password("password")
    assert !u.save
  end

  def test_create__validates_unique_email
    u = Usr.new
    u.login = 'new_usr'
    u.email= usrs(:tesla).email
    u.change_password("password")
    assert !u.save
  end

end
