class User < ApplicationRecord
  # inclusion de uploader
  mount_uploader :image, ImageUploader


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :associate_user_etabs
  has_many :etablissement, through: :associate_user_etabs

  has_many :inscriptions
  has_many :etablissement, through: :inscriptions

  has_many :vague, through: :inscriptions

  has_many :filiere, through: :inscriptions

  has_many :province, through: :inscriptions

  has_many :level, through: :inscriptions
  
  #validation image
  #has_attached_file :image, 
  #validates_attachment :image, content_type: ["image/jpeg", "image/png", "image/gif"]
#  size: { in: 0..10.kilobytes }
  

  #user can follows
  acts_as_follower
  # liker etab
  acts_as_liker
end
