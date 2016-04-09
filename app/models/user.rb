# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string           default(""), not null
#  uid                    :string           default(""), not null
#  provider               :string           default(""), not null
#  image_url              :string
#  twiuser                :string           default("")
#

class User < ActiveRecord::Base


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable # confirmable

  #アソシエーション
  has_many :blogs , dependent: :destroy
  mount_uploader :image_url, ImageUploader


  #FaceBook用
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(provider: auth.provider, uid: auth.uid).first


    unless user

      exist_user =  User.where(email: auth.info.email).first
      if exist_user
        exist_user.provider = auth.provider
        exist_user.uid = auth.uid
        exist_user.save
        return exist_user
      else

      if auth.info.email.nil?
        user = User.new(name: auth.extra.raw_info.name, provider: auth.provider, uid: auth.uid, email: User.create_unique_email, password: Devise.friendly_token[0,20])
      user.skip_confirmation!
      user.save(validate: false)
      else
        user = User.new(name: auth.extra.raw_info.name, provider: auth.provider, uid: auth.uid, email: auth.info.email, password: Devise.friendly_token[0,20])
      user.skip_confirmation!
      user.save(validate: false)

      end

      end
    end
    user
  end

  #Twitter用
  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    user = User.where(provider: auth.provider, uid: auth.uid).first

    unless user
      user = User.new(name: auth.info.nickname, provider: auth.provider, uid: auth.uid, email: User.create_unique_email, password: Devise.friendly_token[0,20], twiuser: auth.info.nickname )
      user.skip_confirmation!
      user.save(validate: false)

    end
    user
  end


    def update_without_current_password(params)
    params.delete(:current_password)

    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end

    clean_up_passwords
    update_attributes(params)
  end

  #ランダムな文字列を生成
  def self.create_unique_string
    SecureRandom.uuid
  end

  #ランダムなEmailアドレス生成
  def self.create_unique_email
    User.create_unique_string + "@example.com"
  end

end
