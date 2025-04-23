require_relative '../../../lib/formatter/phone_number/uk'
require_relative '../../../errors/invalid_phone_number_error'

RSpec.describe Formatter::PhoneNumber::Uk do
  describe '.format' do
    context 'when number is nil' do
      it 'gives error when number is nil' do
        expect do
          described_class.format(nil)
        end.to raise_error(InvalidPhoneNumberError, 'Number must be within the valid length')
      end
    end

    context 'when number is invalid due to length' do
      it 'gives error for numbers greator than 13 digits' do
        expect do
          described_class.format('7582392625482923')
        end.to raise_error(InvalidPhoneNumberError, 'Number must be within the valid length')
      end

      it 'gives error for numbers lesses than 10 digits' do
        expect do
          described_class.format('68596')
        end.to raise_error(InvalidPhoneNumberError, 'Number must be within the valid length')
      end
    end

    context 'when number has alpahbets or special characters' do
      it "gives error for numbers with alphabets or special characters other than '+'" do
        expect do
          described_class.format('689dgd596a')
        end.to raise_error(InvalidPhoneNumberError, 'Number is not valid')
      end

      it 'gives error for numbers with alphabets which satifies UK phone number conditions - begins with +44' do
        expect do
          described_class.format('+44 7ast5g8g5j')
        end.to raise_error(InvalidPhoneNumberError, 'Number is not valid')
      end

      it 'gives error for numbers with alphabets which satifies UK phone number conditions - begins with 0' do
        expect do
          described_class.format('07ast5g8g5j')
        end.to raise_error(InvalidPhoneNumberError, 'Number is not valid')
      end

      it 'gives error for numbers with alphabets which satifies UK phone number conditions - begins with 44' do
        expect do
          described_class.format('44 7ast5g8g5j')
        end.to raise_error(InvalidPhoneNumberError, 'Number is not valid')
      end

      it 'gives error for numbers with special characters which satifies UK phone number conditions' do
        expect do
          described_class.format('+447/.'';[(*)')
        end.to raise_error(InvalidPhoneNumberError, 'Number is not valid')
      end
    end

    context "when number doesn't begin with '7'" do
      it "gives error if the number doesn't begin with 7 with +44 format" do
        expect do
          described_class.format('+44 6524856829')
        end.to raise_error(InvalidPhoneNumberError, 'Number is not valid')
      end
      it "gives error if the number doesn't begin with 7 with 44 format" do
        expect do
          described_class.format('44 6524856829')
        end.to raise_error(InvalidPhoneNumberError, 'Number is not valid')
      end
      it "gives error if the number doesn't begin with 7 with 0 format" do
        expect do
          described_class.format('0 6524856829')
        end.to raise_error(InvalidPhoneNumberError, 'Number is not valid')
      end
      it "gives error if the number doesn't begin with 7" do
        expect do
          described_class.format('6524856829')
        end.to raise_error(InvalidPhoneNumberError, 'Number is not valid')
      end
    end

    context 'formats valid numbers' do
      it 'formats a valid number' do
        expect(described_class.format('7123456789')).to eq('+447123456789')
      end

      it 'formats a valid number - begining with 0' do
        expect(described_class.format('07123456789')).to eq('+447123456789')
      end

      it 'formats a valid number - begining with 44' do
        expect(described_class.format('447123456789')).to eq('+447123456789')
      end

      it 'formats a valid number - begining with +44' do
        expect(described_class.format('+447123456789')).to eq('+447123456789')
      end

      it 'removes non-digit characters and formats' do
        expect(described_class.format('07 123 456 789')).to eq('+447123456789')
      end
    end
  end
end
