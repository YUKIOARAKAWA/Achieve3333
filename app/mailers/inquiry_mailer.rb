class InquiryMailer < ApplicationMailer

  #サイト管理者へ通知メール
  def send_Inquiry_maneger(inquiry)
    @inquiry = inquiry
    if Rails.env.production?
      mail(:to => ENV["gmail_sub_pro_add"] ,:subject => 'お問い合わせがありました')
      else
      mail(:to => ENV["gmail_main_add"] ,:subject => 'お問い合わせがありました')
    end

  end

  #お問い合わせ者へ通知メール
  def send_Inquiry(inquiry)
    @inquiry = inquiry
    mail(:to => @inquiry.mail ,:subject => 'お問い合わせを承りました')
  end

  #管理用メールボックスからメールを取得
  def receive(test)
    if Rails.env.production?
    Mail.defaults do
    retriever_method :pop3, :address    => "pop.gmail.com",
                            :port       => 995,
                            :user_name  => ENV["gmail_sub_recent_pro_add"],
                            :password   => ENV["gmail_sub_pro_pass"],
                            :enable_ssl => true
    end

    else
    Mail.defaults do
    retriever_method :pop3, :address    => "pop.gmail.com",
                            :port       => 995,
                            :user_name  => ENV["gmail_main_add"],
                            :password   => ENV["gmail_main_dev_pass"],
                            :enable_ssl => true
    end
    end

  #mail = Mail.find(:what => :all, :count => 3, :order => :asc)
  #mail = Mail.find(count: 2, order: :desc, what: :first)
  mail = Mail.find(:what => :last, :count => 5, :order => :asc)
  mail.each{|var|
    str = var.body
    puts "クラス"
    puts str.class
    puts "クラス"
    puts str.to_s.force_encoding("utf-8")
    var.body = var.body.to_s.force_encoding("utf-8")
puts "クラス2"
    puts str.decoded.to_s.encode("UTF-16BE", "UTF-8", :invalid => :replace, :undef => :replace, :replace => '?').force_encoding("utf-8")
    puts "クラス2"

}


  return mail

   # Mail.find(:what => :last, :count => 3, :order => :asc).each do |mail|
   #   puts mail.subject
   #   puts mail.body.decoded.encode("UTF-8")
   # end
  end

end
