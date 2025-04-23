class InvalidLengthError < InvalidPhoneNumberError
  def message
    'Number must be within the valid length'
  end
end
