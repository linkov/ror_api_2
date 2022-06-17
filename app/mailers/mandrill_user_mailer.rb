require "mandrill"

class MandrillUserMailer < BaseMandrillDeviseMailer

  def recent_rates(rating, project, user_locale, opts={})
    user = project.user
    subject = ""

    if user_locale && user_locale == "de"
      subject = "Du hast Feedback erhalten!"
      template_name = "email_comm_newrates_recently_DE"
    else
      subject = "You've got feedback!"
      template_name = "email_comm_newrates_recently"
    end

    merge_vars = {
      'user_name' => rating.user.name,
      'art_category' => project.artcategory.name,
      'project_title' => project.title,
      'project_id' => project.id,
      'advisor_status' => project.user.status_for_advisor(rating.user_id)
    }

    body = mandrill_template(template_name, merge_vars)
    if (user.email)
      send_mail(user.email, subject, body)
    end
  end

  def new_flex_review(expert, work, opts={})

    flex_url = ENV['EFW_BASE_FLEX_URL']


    subject = "You've got a request!"
    template_name = "email_comm_new_flex_review_brand_1"


    merge_vars = {
      "WORK_LINK" => "#{flex_url}/work/#{work.id}",
      "DISPLAY_NAME" => "",
    }





    body = mandrill_template(template_name, merge_vars)
    if (expert.expertemail)
      send_mail(expert.expertemail, subject, body)
    end


  end

  def sendVideoLessonRequestEmail(message, opts={})
    lesson = message.conversation.lessons.first
    skills = message.conversation.user_skills.map { |user_skill| user_skill.skill.name }.join(',')
    teacher = User.find(lesson.teacher_id)
    student = User.find(lesson.student_id)
    date_time = lesson.meetingtime.in_time_zone(teacher.time_zone)
    date_time = date_time.strftime( "%A %H:%M #{date_time.day.ordinalize} of %B")
    subject = "Paid tutoring request"
    merge_vars = {
      'user_name' => student.name,
      'date_time' => date_time,
      'messagetext' => message.body,
      'art_category' => message.conversation.project.artcategory.name,
      'skill' => skills,
      'project_title' => message.conversation.project.title,
      'conversation_id' => message.conversation.id
    }
    body = mandrill_template('creative_requests_meeting', merge_vars)

    if teacher.email
      send_mail(teacher.email, subject, body)
    end
  end



  def sendVideoLessonScheduledEmail(isReminder, teacher, student, meetingtime, opts={})

  api_url = ENV['EFW_BASE_API_URL']
  app_url = ENV['EFW_BASE_APP_URL']


  subject = "Your scheduled video tutoring is on #{ meetingtime.in_time_zone(teacher.time_zone).strftime( "%Y-%m-%d %H:%M")} /  #{teacher.time_zone} time"


  main_text =  ""
  if isReminder == true
    main_text = "This is a confirmation of your video lesson day and time with #{teacher.email}."
  else
    main_text = "This is a reminder that you have video lesson scheduled with #{teacher.email}."
  end

  merge_vars = {
    "MTITLE" => " #{ meetingtime.in_time_zone(teacher.time_zone).strftime( "%Y-%m-%d %H:%M")} /  #{teacher.time_zone} time",
    "TEXT" => main_text
  }





  body = mandrill_template('general_template', merge_vars)
  if (student.email)
    send_mail(student.email, subject, body)
  end


end

  def sendIdeasFeedback(email, text, opts={})

    api_url = ENV['EFW_BASE_API_URL']
    app_url = ENV['EFW_BASE_APP_URL']

    subject = "#{email} left a suggestion"




    merge_vars = {
      "EMAIL" => email,
      "TEXT" => text,
    }





    body = mandrill_template('email_ideas', merge_vars)
    if (email)
      send_mail('', subject, body)
    end


  end

  def sendSupportFeedback(email, text, opts={})



    api_url = ENV['EFW_BASE_API_URL']
    app_url = ENV['EFW_BASE_APP_URL']


    subject = "#{email} left support request"




    merge_vars = {
      "EMAIL" => email,
      "TEXT" => text,
    }





    body = mandrill_template('email_support', merge_vars)
    if (email)
      send_mail('', subject, body)
    end


  end


  def feedback_invite_advisor(category, project, user_name, email, opts={})


    preview = project.preview

    api_url = ENV['EFW_BASE_API_URL']
    app_url = ENV['EFW_BASE_APP_URL']

    if user_name == nil
      user_name = email
    end

    if preview == nil
      preview = 'https://gallery.mailchimp.com/7c52f094693159ed5fe033aa9/images/6f3273fb-2c0b-4093-9ad9-fc3160a53244.png'
    end

    subject = "#{user_name} invited you to give feeback on their project"
    template_name = "email_private_invite_to_friend"

    out_string = "Hey, would be lovely if you could follow the link and help me out."
    work_link = "#{app_url}/rateflow"



    merge_vars = {
      "WORK_PREVIEW" => preview,
      "WORK_LINK" => work_link,
      "USER_NAME" => user_name,
      "TEXT" => out_string,
      "WORK_CATEGORY" => category
    }





    body = mandrill_template(template_name, merge_vars)
    if (email)
      send_mail(email, subject, body)
    end


  end




  def feedback_invite(category, invite_id, text, project, user_name, email, opts={})

    api_url = ENV['EFW_BASE_API_URL']
    app_url = ENV['EFW_BASE_APP_URL']

    subject = "#{user_name} invited you to give feeback on their project"
    template_name = "email_private_invite_to_friend"

    out_string = "I found this website that gives structured feedback and will help me to improve my artwork. Would be lovely if you could follow the link and help me out, no sign in required and it's free."

    work_link = "#{app_url}/rateflow/#{project.sharetoken}"


    if text && text.length != 0
      out_string = text
    end



    merge_vars = {
      "WORK_PREVIEW" => project.preview,
      "WORK_LINK" => work_link,
      "USER_NAME" => user_name,
      "TEXT" => out_string,
      "WORK_CATEGORY" => category
    }





    body = mandrill_template(template_name, merge_vars)
    if (email)
      send_mail(email, subject, body)
    end


  end

  def new_rates_mvp(record, user, opts={})

    api_url = ENV['EFW_BASE_API_URL']
    app_url = ENV['EFW_BASE_APP_URL']
    review_payment = Reviewpayment.where(:work_id => record.id).first
    expert = User.find(review_payment.user_id)

    out_string = ""
    subject = ""

    subject = "You've got feedback!"
    out_string += "Expert"
    template_name = "email_comm_newrates_mvp"



    merge_vars = {
      "WORK_LINK" => "#{app_url}/statdetail/#{record.id}",
      "EXPERT_PIC" => expert.picture.url(:preview),
      "NUM_PEOPLE" => out_string
    }





    body = mandrill_template(template_name, merge_vars)
    if (record.user.email)
      send_mail(record.user.email, subject, body)
    end


  end

  def new_rates(record,people_count,user_locale, opts={})

    api_url = ENV['EFW_BASE_API_URL']
    app_url = ENV['EFW_BASE_APP_URL']

    out_string = ""
    subject = ""


    if user_locale && user_locale == "de"
      subject = "Du hast Feedback erhalten!"
      if people_count == 1
        out_string += people_count.to_s+" Person"
      else
        out_string += people_count.to_s+" Leuten"
      end

      template_name = "email_comm_newrates_v2_DE"

    else
      subject = "You've got feedback!"
      if people_count == 1
        out_string += people_count.to_s+" person"
      else
        out_string += people_count.to_s+" people"
      end
      template_name = "email_comm_newrates_v2"
    end


    merge_vars = {
      "WORK_LINK" => "#{app_url}/community/statdetail?project_id=#{record.id}",
      "DISPLAY_NAME" => record.title || "Untitled",
      "NUM_PEOPLE" => out_string
    }





    body = mandrill_template(template_name, merge_vars)
    if (record.user.email)
      send_mail(record.user.email, subject, body)
    end


  end

  def confirmation_instructions(record, token, opts={})

    api_url = ENV['EFW_BASE_API_URL']
    app_url = ENV['EFW_BASE_APP_URL']


    merge_vars = {
      "CONFIRM_LINK" => "#{api_url}/auth/confirmation?config=default&confirmation_token=#{record.confirmation_token}&redirect_url=#{app_url}/registrationconfirm",
      "DISPLAY_NAME" => record.name || record.email
    }


    template_name = "email_comm_signup_confirm"
    subject = "Verify your email address"


    body = mandrill_template(template_name, merge_vars)
    send_mail(record.email, subject, body)

  end


  def reset_password_instructions(record, token, opts={})

    api_url = ENV['EFW_BASE_API_URL']
    app_url = ENV['EFW_BASE_APP_URL']

    if I18n.locale == "de"
      template_name = "email_comm_password_reset-de"
    else
      template_name = "email_comm_password_reset"
    end

    subject = "password reset"
    merge_vars = {
      "PASSWORD_RESET_LINK" => "#{api_url}/auth/password/edit.json?config=default&reset_password_token=#{token}&redirect_url=#{app_url}/confirmreset",
      "DISPLAY_NAME" => record.name || record.email
    }

    body = mandrill_template("email_comm_password_reset", merge_vars)
    send_mail(record.email, subject, body)
  end



end
