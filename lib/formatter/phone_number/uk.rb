module Formatter
  module PhoneNumber
    # Formats UK phone numbers
    module Uk
      COUNTRY_CODE = '+44'.freeze

      def self.format(number)
        number = remove_spaces(number)
        raise InvalidPhoneNumberError, 'Number must be within the valid length' if invalid_length?(number)

        number = sanitize_number(number)
        last10 = last_10_digits(number)
        return append_code(last10) if valid_uk_number?(number)

        raise InvalidPhoneNumberError, 'Number is not valid'
      end

      def self.invalid_length?(number)
        number.length > 13 || number.length < 10
      end

      def self.append_code(number)
        COUNTRY_CODE + number
      end

      def self.remove_spaces(number)
        number.to_s.delete(' ')
      end

      def self.sanitize_number(number)
        number.delete('^0-9')
      end

      def self.last_10_digits(number)
        number.slice(-10, 10)
      end

      def self.valid_uk_number?(number)
        valid_local?(number) ||
          valid_zero?(number) ||
          valid_double_four?(number) ||
          valid_plus_double_four?(number)
      end

      def self.valid_local?(number)
        number.length == 10 && number.start_with?('7')
      end

      def self.valid_zero?(number)
        number.length == 11 && number.start_with?('07')
      end

      def self.valid_double_four?(number)
        number.length == 12 && number.start_with?('447')
      end

      def self.valid_plus_double_four?(number)
        number.length == 13 && number.start_with?('+447')
      end
    end
  end
end
