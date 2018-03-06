class User < ActiveRecord::Base
    has_secure_password
    validates :password, :name, :email, :password_confirmation, presence: true
    validates_uniqueness_of :email, :case_sensitive => false
    validates :password, length: { minimum: 5 }
    has_many :reviews

    def self.authenticate_with_credentials(email, password)
        email = email.strip
        user = User.find_by(email: email)
        
        if user && user.authenticate(password)
            return user
        end
        nil
    end

end
