class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #include Elasticsearch::Model
  #include Elasticsearch::Model::Callbacks
  STATUS = %w(single married)
  alias_attribute :birthday, :dob
  acts_as_birthday :birthday, :anniversary

  has_many :personal_docs, class_name:'PersonalDoc', dependent: :destroy
  has_many :official_docs, class_name:'OfficialDoc', dependent: :destroy
  has_many :educational_docs, class_name:'EducationalDoc', dependent: :destroy
  validates :first_name, :last_name, :dob, :gender, :mobileno, :address, :status, presence: true
  validates :mobileno, uniqueness: true, if: Proc.new { |user| user.mobileno.present? }
  validates_format_of :dob, :with => /\d{4}\-\d{2}\-\d{2}/, :message => '^Date must be in the following format: yyyy/mm/dd', if: Proc.new { |date| date.dob.present? }
  validates :status, inclusion: { in: STATUS, message: "%{value} is not a valid status" }, if: Proc.new { |user| user.status.present? }
  validates_presence_of :anniversary, message: "Please enter the anniversary date", if: Proc.new { |user| user.status != 'single' }
  validate :anniversary_date
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  def self.search(text)
    __elasticsearch__.search(text)
  end

  def name
    "#{first_name} #{last_name}"
  end

  def age
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end

  def anniversary_date
    errors.add(:anniversary, "Please don't enter the anniversary date if you are single") if(status == 'single' && anniversary.present?)
  end
end

#User.import force: true # for auto sync model with elastic search
