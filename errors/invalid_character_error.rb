class InvalidCharacterError < InvalidPhoneNumberError
  def message
    "Number contains invalid characters. Only digits and a leading '+' are allowed"
  end
end
