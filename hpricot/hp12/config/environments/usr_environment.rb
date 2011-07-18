module UsrSystem
  CONFIG = {
    # Source address for usr emails
    :email_from => 'hpricot@hpricot.com',

    # Destination email for system errors
    :admin_email => 'hpricot@hpricot.com',

    # Sent in emails to usrs
    :app_url => 'http://hpricot.com/',

    # Sent in emails to usrs
    :app_name => 'hpricot.com',

    # Email charset
    :mail_charset => 'utf-8',

    # Security token lifetime in hours
    :security_token_life_hours => 240,
  }
end
