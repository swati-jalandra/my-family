class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :documents, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable
end
