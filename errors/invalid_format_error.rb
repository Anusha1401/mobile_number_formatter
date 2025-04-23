class InvalidFormatError < InvalidPhoneNumberError
  def message
    'Number is not valid'
  end
end