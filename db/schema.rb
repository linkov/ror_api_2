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

ActiveRecord::Schema.define(version: 2021_03_15_092755) do

  create_table "advisordates", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "day"
    t.integer "time"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_advisordates_on_user_id"
  end

  create_table "artcategories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.bigint "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order"
    t.boolean "bound_to_skill", default: false
    t.boolean "is_active", default: false
    t.index ["parent_id"], name: "index_artcategories_on_parent_id"
  end

  create_table "artcategory_skills", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "artcategory_id"
    t.bigint "skill_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order", default: 0
    t.index ["artcategory_id"], name: "index_artcategory_skills_on_artcategory_id"
    t.index ["skill_id"], name: "index_artcategory_skills_on_skill_id"
  end

  create_table "artfields", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "tag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "artrelations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "fromcategory_id"
    t.integer "tocategory_id"
    t.float "weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "arttagfields", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "arttags", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "arttagfield_id"
    t.index ["arttagfield_id"], name: "index_arttags_on_arttagfield_id"
  end

  create_table "avconversions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "jobid"
    t.string "url"
    t.string "thumb"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "avfeedbacklanes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "avratingparam_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "projectfile_id"
    t.bigint "rating_id"
    t.index ["avratingparam_id"], name: "index_avfeedbacklanes_on_avratingparam_id"
    t.index ["projectfile_id"], name: "index_avfeedbacklanes_on_projectfile_id"
    t.index ["rating_id"], name: "index_avfeedbacklanes_on_rating_id"
  end

  create_table "avratingparams", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.bigint "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "color"
    t.index ["project_id"], name: "index_avratingparams_on_project_id"
  end

  create_table "avtimelevels", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.float "timeposition"
    t.integer "level"
    t.bigint "avfeedbacklane_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order"
    t.string "command"
    t.index ["avfeedbacklane_id"], name: "index_avtimelevels_on_avfeedbacklane_id"
  end

  create_table "cards", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "story_id"
    t.string "imageurl"
    t.text "text"
    t.string "title"
    t.boolean "active", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order"
    t.index ["story_id"], name: "index_cards_on_story_id"
  end

  create_table "cards_users", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "card_id", null: false
  end

  create_table "categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "tag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "parentcategory_id"
    t.index ["parentcategory_id"], name: "index_categories_on_parentcategory_id"
  end

  create_table "categoryrelations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.float "weight"
    t.bigint "fromcategory_id"
    t.bigint "tocategory_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "fromparentcategory_id"
    t.bigint "toparentcategory_id"
    t.index ["fromcategory_id"], name: "index_categoryrelations_on_fromcategory_id"
    t.index ["fromparentcategory_id"], name: "index_categoryrelations_on_fromparentcategory_id"
    t.index ["tocategory_id"], name: "index_categoryrelations_on_tocategory_id"
    t.index ["toparentcategory_id"], name: "index_categoryrelations_on_toparentcategory_id"
  end

  create_table "conversation_userskills", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "conversation_id"
    t.bigint "user_skill_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "advisorrate"
    t.index ["conversation_id"], name: "index_conversation_userskills_on_conversation_id"
    t.index ["user_skill_id"], name: "index_conversation_userskills_on_user_skill_id"
  end

  create_table "conversations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "sender_id"
    t.bigint "recipient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "projectfile_id"
    t.boolean "isclarification", default: false
    t.datetime "meetingtime"
    t.boolean "meetingconfirmed", default: false
    t.boolean "meetingfinished", default: false
    t.integer "advisorrate"
    t.index ["project_id"], name: "index_conversations_on_project_id"
    t.index ["projectfile_id"], name: "index_conversations_on_projectfile_id"
    t.index ["recipient_id"], name: "index_conversations_on_recipient_id"
    t.index ["sender_id"], name: "index_conversations_on_sender_id"
  end

  create_table "feedbacks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "text"
    t.integer "order"
    t.string "feedbacktype"
    t.text "link"
    t.bigint "rating_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "drawing"
    t.bigint "avratingparam_id"
    t.float "avtracktimeposition"
    t.index ["avratingparam_id"], name: "index_feedbacks_on_avratingparam_id"
    t.index ["rating_id"], name: "index_feedbacks_on_rating_id"
  end

  create_table "feedbacksessions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "paymentamount"
    t.boolean "paid", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "heros", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invites", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.string "email"
    t.text "message"
    t.string "name"
    t.bigint "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "sent", default: false
    t.index ["project_id"], name: "index_invites_on_project_id"
  end

  create_table "lessons", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "start"
    t.datetime "end"
    t.integer "teacher_id"
    t.integer "student_id"
    t.integer "pronunciation_rate"
    t.integer "knowledge_rate"
    t.integer "explanation_rate"
    t.text "positive_comment"
    t.text "negative_comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.text "token"
    t.integer "seconds"
    t.bigint "conversation_id"
    t.bigint "project_id"
    t.boolean "confirmed"
    t.boolean "finished", default: false
    t.boolean "paid", default: false
    t.datetime "meetingtime"
    t.boolean "rated", default: false
    t.boolean "paymentrequestapproved", default: false
    t.boolean "paymentrequestdenied", default: false
    t.index ["conversation_id"], name: "index_lessons_on_conversation_id"
    t.index ["project_id"], name: "index_lessons_on_project_id"
  end

  create_table "messages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "body"
    t.bigint "conversation_id"
    t.boolean "read"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "paymentrequestamount"
    t.boolean "paymentrequestapproved", default: false
    t.integer "paymentrequesttime"
    t.boolean "paymentrequestdenied", default: false
    t.boolean "special", default: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "myadvisers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "adviserid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_myadvisers_on_user_id"
  end

  create_table "newsfeedfollows", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id"
    t.integer "artist_id"
    t.integer "commenter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "project_id"
  end

  create_table "parentcategories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "tag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "artfield_id"
    t.index ["artfield_id"], name: "index_parentcategories_on_artfield_id"
  end

  create_table "presenterquestionanswers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "presenterquestion_id"
    t.text "answer"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["presenterquestion_id"], name: "index_presenterquestionanswers_on_presenterquestion_id"
    t.index ["user_id"], name: "index_presenterquestionanswers_on_user_id"
  end

  create_table "presenterquestions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "project_id"
    t.text "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_presenterquestions_on_project_id"
  end

  create_table "project_skills", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "skill_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_project_skills_on_project_id"
    t.index ["skill_id"], name: "index_project_skills_on_skill_id"
  end

  create_table "projectadvisors", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "myadviser_id"
    t.boolean "invitesent", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["myadviser_id"], name: "index_projectadvisors_on_myadviser_id"
    t.index ["project_id"], name: "index_projectadvisors_on_project_id"
  end

  create_table "projectfiles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "handle"
    t.string "mimetype"
    t.bigint "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "url"
    t.integer "width"
    t.integer "height"
    t.integer "order"
    t.integer "likecount", default: 0
    t.string "conversionjobid"
    t.text "filedescription"
    t.boolean "showinfo", default: false
    t.index ["project_id"], name: "index_projectfiles_on_project_id"
  end

  create_table "projectquestionanswers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "project_id"
    t.text "answer"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_projectquestionanswers_on_project_id"
    t.index ["user_id"], name: "index_projectquestionanswers_on_user_id"
  end

  create_table "projectresorts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "project_id"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_projectresorts_on_project_id"
    t.index ["user_id"], name: "index_projectresorts_on_user_id"
  end

  create_table "projects", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "category_id"
    t.string "purpose"
    t.bigint "parentcategory_id"
    t.boolean "private", default: false
    t.string "preview"
    t.bigint "artcategory_id"
    t.boolean "choosethebest", default: false
    t.text "presenterquestion"
    t.string "insightscategory", default: "Inspiring"
    t.decimal "inspiringrate", precision: 10, default: "200"
    t.string "sharetoken"
    t.boolean "show_payment_promise_to_anon", default: false
    t.index ["artcategory_id"], name: "index_projects_on_artcategory_id"
    t.index ["category_id"], name: "index_projects_on_category_id"
    t.index ["parentcategory_id"], name: "index_projects_on_parentcategory_id"
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "ratebacks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "feedback_id"
    t.integer "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feedback_id"], name: "index_ratebacks_on_feedback_id"
  end

  create_table "ratings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "project_id"
    t.integer "slidervalue", default: 50
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "projectfile_id"
    t.string "ratingtype"
    t.integer "categoryrelation_id"
    t.integer "feedbacksession_id"
    t.index ["project_id"], name: "index_ratings_on_project_id"
    t.index ["projectfile_id"], name: "index_ratings_on_projectfile_id"
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "resortimages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "order"
    t.bigint "projectfile_id"
    t.bigint "projectresort_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["projectfile_id"], name: "index_resortimages_on_projectfile_id"
    t.index ["projectresort_id"], name: "index_resortimages_on_projectresort_id"
  end

  create_table "reviewqueues", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_reviewqueues_on_project_id"
    t.index ["user_id"], name: "index_reviewqueues_on_user_id"
  end

  create_table "settings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.decimal "value", precision: 13, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "settingtype"
  end

  create_table "skills", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "link"
    t.string "shortname"
  end

  create_table "skips", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "skiptime"
    t.bigint "project_id"
    t.bigint "category_id"
    t.bigint "parentcategory_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "artcategory_id"
    t.integer "parentartcategory_id"
    t.index ["artcategory_id"], name: "index_skips_on_artcategory_id"
    t.index ["category_id"], name: "index_skips_on_category_id"
    t.index ["parentcategory_id"], name: "index_skips_on_parentcategory_id"
    t.index ["project_id"], name: "index_skips_on_project_id"
    t.index ["user_id"], name: "index_skips_on_user_id"
  end

  create_table "stories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "flow"
    t.boolean "active", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  create_table "tagfeedbacks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "arttag_id"
    t.integer "count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "projectfile_id"
    t.index ["arttag_id"], name: "index_tagfeedbacks_on_arttag_id"
    t.index ["projectfile_id"], name: "index_tagfeedbacks_on_projectfile_id"
  end

  create_table "transactions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "transactiontype"
    t.decimal "value", precision: 13, scale: 2
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "unconnected_payments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "student_id"
    t.integer "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_unconnected_payments_on_user_id"
  end

  create_table "user_skills", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "skill_id"
    t.integer "level"
    t.integer "rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order", default: 0
    t.index ["skill_id"], name: "index_user_skills_on_skill_id"
    t.index ["user_id"], name: "index_user_skills_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.string "nickname"
    t.string "image"
    t.string "email"
    t.text "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin"
    t.string "referral_token"
    t.integer "referred_by"
    t.string "website"
    t.string "city"
    t.boolean "showimage", default: false
    t.boolean "showcity", default: false
    t.boolean "showname", default: false
    t.boolean "showwebsite", default: false
    t.integer "gender", default: 0
    t.boolean "signup_form_shown", default: false
    t.string "stripe_user_id"
    t.decimal "advisorrate", precision: 10, default: "500"
    t.text "lang"
    t.string "stripe_customer_id"
    t.boolean "showtutorials", default: false
    t.string "sharetoken"
    t.string "profileimage"
    t.boolean "isteam", default: false
    t.string "time_zone", default: "UTC"
    t.boolean "online", default: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "advisordates", "users"
  add_foreign_key "artcategory_skills", "artcategories"
  add_foreign_key "artcategory_skills", "skills"
  add_foreign_key "arttags", "arttagfields"
  add_foreign_key "avfeedbacklanes", "avratingparams"
  add_foreign_key "avfeedbacklanes", "projectfiles"
  add_foreign_key "avfeedbacklanes", "ratings"
  add_foreign_key "avratingparams", "projects"
  add_foreign_key "avtimelevels", "avfeedbacklanes"
  add_foreign_key "cards", "stories"
  add_foreign_key "categories", "parentcategories"
  add_foreign_key "conversation_userskills", "conversations"
  add_foreign_key "conversation_userskills", "user_skills"
  add_foreign_key "feedbacks", "ratings"
  add_foreign_key "invites", "projects"
  add_foreign_key "lessons", "conversations"
  add_foreign_key "messages", "conversations"
  add_foreign_key "messages", "users"
  add_foreign_key "myadvisers", "users"
  add_foreign_key "parentcategories", "artfields"
  add_foreign_key "presenterquestionanswers", "presenterquestions"
  add_foreign_key "presenterquestionanswers", "users"
  add_foreign_key "presenterquestions", "projects"
  add_foreign_key "project_skills", "projects"
  add_foreign_key "project_skills", "skills"
  add_foreign_key "projectadvisors", "myadvisers"
  add_foreign_key "projectadvisors", "projects"
  add_foreign_key "projectfiles", "projects"
  add_foreign_key "projectquestionanswers", "projects"
  add_foreign_key "projectquestionanswers", "users"
  add_foreign_key "projectresorts", "projects"
  add_foreign_key "projectresorts", "users"
  add_foreign_key "projects", "artcategories"
  add_foreign_key "projects", "parentcategories"
  add_foreign_key "projects", "users"
  add_foreign_key "ratebacks", "feedbacks"
  add_foreign_key "ratings", "projects"
  add_foreign_key "ratings", "users"
  add_foreign_key "resortimages", "projectfiles"
  add_foreign_key "resortimages", "projectresorts"
  add_foreign_key "reviewqueues", "projects"
  add_foreign_key "reviewqueues", "users"
  add_foreign_key "skips", "artcategories"
  add_foreign_key "skips", "projects"
  add_foreign_key "skips", "users"
  add_foreign_key "tagfeedbacks", "arttags"
  add_foreign_key "tagfeedbacks", "projectfiles"
  add_foreign_key "transactions", "users"
  add_foreign_key "unconnected_payments", "users"
  add_foreign_key "user_skills", "skills"
  add_foreign_key "user_skills", "users"
end
