require 'rails_helper'

describe Admin::ArticlesController, type: :controller do
  it "should send an email when an article is submitted" do
    article = create(:article)
    # post submit_for_review_admin_article_path(article)

    # expect(ContentMailer).to have_received(:notify_content_submitted).and_return(double(deliver_later: true))
    expect(ContentMailer).to receive(:with).with(content: article.content).and_return(
      double(notify_content_submitted: double(deliver_later: true))
    )

    # content_mailer_double = double(notify_content_submitted: double(deliver_later))
    # allow(ContentMailer).to receive(:with).and_return(content_mailer_double)

    post "in_review", params: { id: article.id }
  end

  it "should not send an email if the article contains restricted words" do
    article = create(:article, title: "This is a fxxx")

    expect(ContentMailer).not_to receive(:with).with(content: article.content)
    post :in_review, params: { id: article.id }

    expect(response).to have_http_status(:unprocessable_entity)
    expect(article.errors[:title]).to include("contains restricted language and cannot be saved")
  end

  it "should send an email when an article is submitted without restricted words" do
    article = create(:article, title: "This is a safe title")

    expect(ContentMailer).to receive(:with).with(content: article.content).and_return(
      double(notify_content_submitted: double(deliver_later: true))
    )
    post :in_review, params: { id: article.id }

    expect(response).to have_http_status(:ok)
  end
end