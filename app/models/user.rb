class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :sex

  has_many :recipes,dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :recipes, through: :likes

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # validates :nickname, :encrypted_password, :lastname, :firstname, :zipcode, :pref_id, :city, :address, :lastname_kana, :firstname_kana, :birthyear_id, :birthmonth_id, :birthday_id, presence: true
  # validates :password, presence: true, length: { minimum: 7 }, confirmation: true
  # validates :password_confirmation, presence: true, length: { minimum: 7 }
  # validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/ }
  # validates :lastname,:firstname,:lastname_kana,:firstname_kana, 
  #   format: { with: /\A[ぁ-んァ-ン一-龥]/ }

end
