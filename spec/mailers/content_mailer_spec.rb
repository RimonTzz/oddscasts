require "rails_helper"

RSpec.describe ContentMailer, type: :mailer do
  describe "notify_content_submitted" do
    let(:content) { double("Content", title: "Test Title", description: "Test Description") }
    let(:mail) { ContentMailer.notify_content_submitted(content: content) }

    it "renders the headers" do
      expect(mail.subject).to eq("Article was ready for approval")
      expect(mail.to).to eq(["b6412203@g.sut.ac.th"])
      expect(mail.from).to eq(["b6412203@g.sut.ac.th"]) 
    end

    it "renders the body" do
      expect(mail.body.encoded).to include("Content Title: Test Title")
      expect(mail.body.encoded).to include("Content Description: Test Description")
    end
  end
end
