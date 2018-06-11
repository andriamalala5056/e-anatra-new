# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_06_07_171820) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string "titre"
    t.text "message"
    t.string "photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "etablissement_id"
    t.index ["etablissement_id"], name: "index_articles_on_etablissement_id"
  end

  create_table "associate_filiere_etabs", force: :cascade do |t|
    t.bigint "filiere_id"
    t.bigint "etablissement_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["etablissement_id"], name: "index_associate_filiere_etabs_on_etablissement_id"
    t.index ["filiere_id"], name: "index_associate_filiere_etabs_on_filiere_id"
  end

  create_table "associate_niveau_etabs", force: :cascade do |t|
    t.bigint "niveau_id"
    t.bigint "etablissement_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["etablissement_id"], name: "index_associate_niveau_etabs_on_etablissement_id"
    t.index ["niveau_id"], name: "index_associate_niveau_etabs_on_niveau_id"
  end

  create_table "associate_user_etabs", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "etablissement_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["etablissement_id"], name: "index_associate_user_etabs_on_etablissement_id"
    t.index ["user_id"], name: "index_associate_user_etabs_on_user_id"
  end

  create_table "etablissements", force: :cascade do |t|
    t.string "nom"
    t.string "mail"
    t.string "telephone"
    t.string "adress"
    t.text "description"
    t.string "category"
    t.float "longitude"
    t.float "latitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "dossier_a_fournir_file_name"
    t.string "dossier_a_fournir_content_type"
    t.integer "dossier_a_fournir_file_size"
    t.datetime "dossier_a_fournir_updated_at"
  end

  create_table "filieres", force: :cascade do |t|
    t.string "nom"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "niveaus", force: :cascade do |t|
    t.string "niveau"
    t.integer "place"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nom"
    t.string "prenom"
    t.string "sexe"
    t.datetime "date_de_naissance"
    t.string "adresse"
    t.string "telephone"
    t.bigint "role_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "articles", "etablissements"
  add_foreign_key "associate_filiere_etabs", "etablissements"
  add_foreign_key "associate_filiere_etabs", "filieres"
  add_foreign_key "associate_niveau_etabs", "etablissements"
  add_foreign_key "associate_niveau_etabs", "niveaus"
  add_foreign_key "associate_user_etabs", "etablissements"
  add_foreign_key "associate_user_etabs", "users"
  add_foreign_key "users", "roles"
end
