class ContentMailer < ApplicationMailer
  def notify_content_submitted(params)
    @content = params[:content]
    mail(
      to: "b6412203@g.sut.ac.th",
      subject: "Article was ready for approval",
      body: "Content Title: #{@content.title}\nContent Description: #{@content.description}"
    )
  end
end
