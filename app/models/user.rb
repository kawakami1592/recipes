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

  validates :nickname, :encrypted_password, :sex_id, presence: true
  validates :password, presence: true, length: { minimum: 7 }, confirmation: true
  validates :password_confirmation, presence: true, length: { minimum: 7 }
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/ }

end
