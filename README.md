# UK Phone Number Formatter

A simple Ruby library for formatting UK mobile phone numbers.  
It removes non-digit characters and ensures numbers are valid before formatting them into a readable UK format (e.g., `+447123456789`).

---

## Installation

This is a standalone Ruby library. Clone or download the repo and run the test cases.

```bash
git clone https://github.com/Anusha1401/mobile_number_formatter.git/
cd mobile_number_formatter
bundle install
rspec spec/formatter/phone_number/uk_spec.rb