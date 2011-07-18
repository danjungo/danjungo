module UsrHelper

  DEFAULT_HEAD_OPTIONS = {
    :notice => true,
    :message => true,
    :error => false
  }.freeze unless defined? DEFAULT_HEAD_OPTIONS 

  def title_helper
    "#{@controller.controller_class_name} #{@controller.action_name}"
  end

  def head_helper(label, options = {})
    notice = message = error = nil
    opts = DEFAULT_HEAD_OPTIONS.dup
    opts.update(options.symbolize_keys)
    s = "<h3>#{label}</h3>"
    if flash['notice'] and not opts[:notice].nil? and opts[:notice]
      notice = "<div><p>#{flash['notice']}</p></div>"
      s = s + notice
    end
    if flash['message'] and not opts[:message].nil? and opts[:message]
      message = "<div id=\"ErrorExplanation\"><p>#{flash['message']}</p></div>"
      s = s + message
    end
    if not opts[:error].nil? and opts[:error]
     error = error_messages_for('usr')
     if not error.nil?
       error = error + "<br/>"
       s = s + error
     end
   end
   return s
  end

end
