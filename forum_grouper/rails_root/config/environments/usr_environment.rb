module UsrSystem
  CONFIG = {
    # Source address for usr emails
    :email_from => 'ForumGrouper@ForumGrouper.com',

    # Destination email for system errors
    :admin_email => 'ForumGrouper@ForumGrouper.com',

    # Sent in emails to usrs
    :app_url => 'http://ForumGrouper.com/',

    # Sent in emails to usrs
    :app_name => 'ForumGrouper',

    # Email charset
    :mail_charset => 'utf-8',

    # Security token lifetime in hours
    :security_token_life_hours => 240,
  }
end

