require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "activate_account" do
    let(:mail) { UserMailer.activate_account }

    it "renders the headers" do
      expect(mail.subject).to eq("Activate account")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

  describe "welcome" do
    let(:mail) { UserMailer.welcome }

    it "renders the headers" do
      expect(mail.subject).to eq("Welcome")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
