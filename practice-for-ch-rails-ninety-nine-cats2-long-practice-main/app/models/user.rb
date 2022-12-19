class User < ApplicationRecord
    validates :username, presence: true
    validates :password_digest, presence: true
    validates :session_token, presence: true

    before_validation :ensure_session_token

    def password= (new_pass)
        self.password_digest = BCrypt::Password.create(new_pass) if is_password?(new_pass)
        @password = new_pass
    end

    def is_password?(new_pass)
        password_object = BCrypt::Password.new(self.password_digest)
        password_object.is_password?(new_pass)
    end

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)
        if user && user.is_password?(password)
            user
        else 
            nil
        end
    end

    def reset_session_token!
        token = generate_unique_session_token
        self.save!
        return token
    end 

    private
    def generate_unique_session_token
        self.session_token = SecureRandom::urlsafe_base64
    end

    def ensure_session_token
        if self.session_token = nil
            generate_unique_session_token
        end
    end
end
