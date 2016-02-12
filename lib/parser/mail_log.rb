module Parser
  # Parse mail log file and create rows in db
  class MailLog
    def initialize(log_file)
      @path = log_file
      @postfix_id = postfix_pattern
      @subject = subject_pattern
      @message = message_pattern
      @status = status_pattern
    end

    def parse_log
      File.foreach(@path) do |line|
        data = @postfix_id.match(line)
        create_row data
        subject = @subject.match(line)
        update_subject subject
        message = @message.match(line)
        update_message message
        recipient = @status.match(line)
        create_recipient recipient
      end
    end

    private

    def postfix_pattern
      %r{
        postfix\/smtpd\[\d*\]:\s([aA-Z0-9]+):\s
        client=#{Rails.application.secrets.log_mail_server}
      }x
    end

    def subject_pattern
      %r{
        postfix\/cleanup\[\d*\]:\s([aA-Z0-9]+):\sinfo:\sheader\sSubject:\s
        (.*)\sfrom\s#{Rails.application.secrets.log_mail_server}
      }x
    end

    def message_pattern
      %r{postfix\/cleanup\[\d*\]: ([aA-Z0-9]+): message-id=(.*)}
    end

    def status_pattern
      %r{
        postfix\/smtp\[\d*\]:\s([aA-Z0-9]+):\s
        to=<(.*)>.*status=((.*)\s\(([0-9]{3})?(.*)\))
      }x
    end

    def create_row(data)
      return if data.nil? || data[1].nil?
      Message.create(postfix_queue_id: data[1],
                     client: Rails.application.secrets.log_mail_server)
    end

    def update_subject(subject)
      return if subject.nil?
      row = Message.where(postfix_queue_id: subject[1]).first
      row.update_attribute(:subject, subject[2]) unless row.nil?
    end

    def update_message(message)
      return if message.nil?
      row = Message.where(postfix_queue_id: message[1]).first
      row.update_attribute(:postfix_message_id, message[2]) unless row.nil?
    end

    def create_recipient(recipient, delivered = false)
      return if recipient.nil?
      row = Message.where(postfix_queue_id: recipient[1]).first
      delivered = true if recipient[5] == '250'
      row.recipients.create(address: recipient[2], status: recipient[4],
                            delivered: delivered, status_raw: recipient[3])
    end
  end
end
