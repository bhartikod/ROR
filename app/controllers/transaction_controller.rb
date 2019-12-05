class TransactionController < ApplicationController
require "rubygems"
require "braintree"

gateway = Braintree::Gateway.new(
  :environment => :sandbox,
  :merchant_id => "rr5znhwwvd7nh3xs",
  :public_key => "hdbf8fngdm47xv6f",
  :private_key => "6fbad75695c175a835de33bf8ab98a5a",
)

result = gateway.transaction.sale(
  :amount => "1000.00",
  :payment_method_nonce => nonce_from_the_client,
  :options => {
    :submit_for_settlement => true
  }
)

if result.success?
  puts "success!: #{result.transaction.id}"
elsif result.transaction
  puts "Error processing transaction:"
  puts "  code: #{result.transaction.processor_response_code}"
  puts "  text: #{result.transaction.processor_response_text}"
else
  p result.errors
end
def customer
	result = gateway.customer.create(:first_name => "Josh")
	if result.success?
  		puts "Created customer #{result.customer.id}"
	else
  		puts "Validations failed"
  		result.errors.for(:customer).each do |error|
    	puts error.message
  	end
end
end
