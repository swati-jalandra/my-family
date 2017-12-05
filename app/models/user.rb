class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :personal_docs, class_name:'PersonalDoc', dependent: :destroy
  has_many :official_docs, class_name:'OfficialDoc', dependent: :destroy
  has_many :educational_docs, class_name:'EducationalDoc', dependent: :destroy
  validates :name, presence: true, uniqueness: true
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable
end
