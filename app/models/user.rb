class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:strava]

  has_many :activities
  has_many :challenges

  def self.create_from_provider_data(provider_data)
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do |user|
      user.email = provider_data.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end



  def self.create_from_strava(provider_data)
    puts "we are in the Strva User creation method"
    puts a = provider_data
    raise

    # Create User
    where(athlete_id: provider_data.athlete.id).first_or_create do |user|

      user.email = provider_data.info.email
      user.password = Devise.friendly_token[0, 20]

    end

    # Create profile

    # Create Short-lived Access Token

    # Create the Refresh Token


  end


end
