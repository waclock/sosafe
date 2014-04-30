class UserMailer < ActionMailer::Base
  default from: "hello@brainshots.cl"

  # Para desuscribirse de ciertos mails(tambiénn debe ser el :from del message. EJ: newsletter@brainshots.cl)
  # @unsubscribe_from = 'un_email@example.com'


  def welcome(user)
    @user = user
    token = @user.tokens.first_or_create
    @token = token.value
    @url  = "http://localhost:3000/activate/#{@token}"

    @unsubscribe_token = @user.tokens.first_or_create.value
    mail(:to => @user.email, :subject => "Welcome")
  end

  def feedback(user)
    @user = user
    @url  = "http://localhost:3000/"

    @unsubscribe_token = @user.generate_or_get_unsubscribe_code
    mail(:to => user.email, :subject => "Feedback")
  end

  def contact_email(name, email, subject, content)
    @nombre = name
    @mail = email
    @asunto = subject
    @contenido = content
    @user = User.new

    mail(:to => "hello@brainshots.cl", :from => email, :subject => "Contact")
  end


  # def send_password(user)
  #   @user = user
  #   @token = ''
  #   @url  = "http://localhost:3000/forgot_password/"+@token

  #   @unsubscribe_token = @user.generate_or_get_unsubscribe_code
  #   mail(:to => user.email, :subject => "Reset your password")
  # end



end
