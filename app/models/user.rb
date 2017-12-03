class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :documents, dependent: :destroy
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable
end
