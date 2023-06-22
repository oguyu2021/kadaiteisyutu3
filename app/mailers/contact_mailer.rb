class PostMailer < ApplicationMailer
  def post_mail(post)
    @post = post

    mail to: @post.email, subject: "お問い合わせの確認メール"
  end
end
