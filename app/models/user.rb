class User < ApplicationRecord
    attr_accessor :password
    before_save :encrypt_password

    has_many :posts

    validates :name, presence: true
    validates :email, presence: true
    #validates :password, presence: true
    #validates :password, confirmation: true 


    #BCrypt authentication
    def self.authenticate(email, password)
        user = find_by_email(email)
        if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
            user 
        else
            nil
        end
    end

    def encrypt_password
        if password.present?
            self.password_salt = BCrypt::Engine.generate_salt
            self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
        end
    end
    
    #Omniauth authentication
    def self.from_omniauth(auth)
        where(provider: auth.provider, uid: auth.uid).first || create_from_omniauth(auth)
    end

    def self.create_from_omniauth(auth)
        create! do |user|
            user.provider = auth["provider"]
            user.uid = auth["uid"]
            user.name = auth["info"]["name"]
            user.email = auth["info"]["email"]
        end
    end

    #Serach function
    def self.search(query)
        where("name like ? OR email like ?", "%#{query}%", "%#{query}%")
    end
end
