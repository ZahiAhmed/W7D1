class User < ApplicationRecord
    validates :username, presence: true
    validates :password_digest, presence: true
    validates :session_token, presence: true

    before_validation :set_token

    def set_token
        self.session_token ||= SecureRandom::urlsafe_base64
    end

    
end
