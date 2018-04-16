class User < ApplicationRecord
  PROVIDERS = %w(facebook github google_oauth2)
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, #:registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: PROVIDERS

  #include Elasticsearch::Model
  #include Elasticsearch::Model::Callbacks
  STATUS = %w(single married)
  GENDER = %w(male female)
  alias_attribute :birthday, :dob
  acts_as_birthday :birthday, :anniversary

  has_many :documents, dependent: :destroy
  has_many :personal_docs, class_name:'PersonalDoc', dependent: :destroy
  has_many :official_docs, class_name:'OfficialDoc', dependent: :destroy
  has_many :educational_docs, class_name:'EducationalDoc', dependent: :destroy
  validates :first_name, :last_name, :dob, :gender, :mobileno, :address, :status, presence: true
  validates :mobileno, uniqueness: true, if: Proc.new { |user| user.mobileno.present? }
  validates_format_of :dob, :with => /\d{4}\-\d{2}\-\d{2}/, :chat => '^Date must be in the following format: yyyy/mm/dd', if: Proc.new { |date| date.dob.present? }
  validates :status, inclusion: {in: STATUS, chat: "%{value} is not a valid status" }, if: Proc.new { |user| user.status.present? }
  validates_presence_of :anniversary, chat: "Please enter the anniversary date", if: Proc.new { |user| user.status != 'single' }
  validate :anniversary_date
  has_many :reminders, dependent: :destroy
  has_many :messages, dependent: :destroy

  class << self
    def search(text)
      __elasticsearch__.search(text)
    end

    PROVIDERS.each do |provider|
      define_method "create_from_#{provider}_data" do |provider_data|
        user = where(email: provider_data.info.email).first
        if user.present?
          user.update_attributes provider: provider_data.provider, uid: provider_data.uid
          return user
        end  
        where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do | user |
          user.first_name = provider_data.info.name
          user.email = provider_data.info.email
          user.password = Devise.friendly_token[0, 20]
          user.save(validate: false)
        end
      end
    end
  end

  # Devise override to ignore the password requirement if the user is authenticated with Google / Facebook / Github / Twitter
  def password_required?
    provider.present? ? false : super
  end

  def name
    "#{first_name} #{last_name}"
  end

  def age
    if dob
      now = Time.now.utc.to_date
      now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
    end
  end

  def anniversary_date
    errors.add(:anniversary, "Please don't enter the anniversary date if you are single") if(status == 'single' && anniversary.present?)
  end
end

#User.import force: true # for auto sync model with elastic search
