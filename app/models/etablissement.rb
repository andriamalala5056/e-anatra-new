class Etablissement < ApplicationRecord
    has_many :associate_user_etabs
    has_many :user, through: :associate_user_etabs

    has_attached_file :dossier_a_fournir    
    validates_attachment :dossier_a_fournir, content_type: { content_type: "application/pdf" }
    

    validates :nom, presence: true
    validates :nom, uniqueness: true

    has_attached_file :image_etablissement, styles: { large: "603.33x426.67>", thumb: "450x300>" }, default_url: "/images/:style/missing.png"
    validates_attachment_content_type :image_etablissement, content_type: /\Aimage\/.*\z/

    has_many :associate_filiere_etabs
    has_many :filiere, through: :associate_filiere_etabs

    has_many :associate_niveau_etabs
    has_many :niveau, through: :associate_niveau_etabs

    has_many :articles

    # etablissemnt followable
    acts_as_followable
    # on peut liker etab
    acts_as_likeable
    
end
