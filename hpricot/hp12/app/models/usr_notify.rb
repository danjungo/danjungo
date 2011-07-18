class UsrNotify < ActionMailer::Base
  def signup(usr, password, url=nil)
    setup_email(usr)

    # Email header info
    @subject += "Welcome to #{UsrSystem::CONFIG[:app_name]}!"

    # Email body substitutions
    @body["name"] = "#{usr.first_name} #{usr.last_name}"
    @body["login"] = usr.login
    @body["password"] = password
    @body["url"] = url || UsrSystem::CONFIG[:app_url].to_s
    @body["app_name"] = UsrSystem::CONFIG[:app_name].to_s
  end

  def forgot_password(usr, url=nil)
    setup_email(usr)

    # Email header info
    @subject += "Forgotten password notification"

    # Email body substitutions
    @body["name"] = "#{usr.first_name} #{usr.last_name}"
    @body["login"] = usr.login
    @body["url"] = url || UsrSystem::CONFIG[:app_url].to_s
    @body["app_name"] = UsrSystem::CONFIG[:app_name].to_s
  end

  def change_password(usr, password, url=nil)
    setup_email(usr)

    # Email header info
    @subject += "Changed password notification"

    # Email body substitutions
    @body["name"] = "#{usr.first_name} #{usr.last_name}"
    @body["login"] = usr.login
    @body["password"] = password
    @body["url"] = url || UsrSystem::CONFIG[:app_url].to_s
    @body["app_name"] = UsrSystem::CONFIG[:app_name].to_s
  end

  def setup_email(usr)
    @recipients = "#{usr.email}"
    @from       = UsrSystem::CONFIG[:email_from].to_s
    @subject    = "[#{UsrSystem::CONFIG[:app_name]}] "
    @sent_on    = Time.now
    @headers['Content-Type'] = "text/plain; charset=#{UsrSystem::CONFIG[:mail_charset]}; format=flowed"
  end
end
