class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:strava]

  has_one :profile, dependent: :destroy
  has_one :refresh_token, dependent: :destroy
  has_one :sl_access_token, dependent: :destroy

  has_many :activities
  has_many :challenges

  def self.create_from_provider_data(provider_data)
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do |user|
      user.email = provider_data.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def self.create_from_strava(provider_data)
    puts "we are in the Strava User creation method"

    where(athlete_id: provider_data.athlete.id).first_or_create do |user|
      # Create User
      # user.email = provider_data.info.email
      user.email = "#{provider_data.athlete.id}@strava.com"
      user.athlete_id = provider_data.athlete.id
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
