module UsrSystem
  CONFIG = {
    # Source address for usr emails
    :email_from => 'edgar411@edgar411.com',

    # Destination email for system errors
    :admin_email => 'edgar411@edgar411.com',

    # Sent in emails to usrs
    :app_url => 'http://edgar411.com/',

    # Sent in emails to usrs
    :app_name => 'edgar411',

    # Email charset
    :mail_charset => 'utf-8',

    # Security token lifetime in hours
    :security_token_life_hours => 240,
  }
end
