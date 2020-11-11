class EmailSenderJob < ApplicationJob
  queue_as :default

  def perform(user)
    ConfirmationMailer.inform(user).deliver_now
  end
end
