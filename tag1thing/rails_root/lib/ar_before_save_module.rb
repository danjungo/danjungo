module ArBeforeSaveModule

  def before_save
    case
    when self.thng.nil?
      self.usr_id= self.thng_id= 1
    when self.usr.nil?
      self.usr= self.thng.usr
    end # case
  end # def before_save

end
