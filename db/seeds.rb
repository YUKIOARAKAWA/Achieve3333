1000.times do |n|
  email = "example-#{n+1}@example.com"
  password = "password#{n+1}"
  uid = n+1
  User.create(email:  email,
              password: password,
              uid: uid)

  content = "投稿#{n+1}"
  user_id = n+1
  Blog.create(content: content,
              user_id: user_id)
end

