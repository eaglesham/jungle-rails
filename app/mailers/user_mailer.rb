class UserMailer < ApplicationMailer
    default from: 'no-reply@jungle.com'

    def receipt_email(order)
        
        mail(to: order.email, subject: "Order #: #{order.id}")
    end
end
