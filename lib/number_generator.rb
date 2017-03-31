class NumberGenerator
  VERSION = "0.1.0".freeze

  attr_reader :message_receiver

  def initialize(message_receiver)
    @message_receiver = message_receiver
  end

  def generate(format: :default)
    case format
      when :date
        [message_receiver.created_at.strftime("%Y%m%d"), generate].join('-')
      else
        '%.5d' % message_receiver.position
    end
  end

  def generate!(format: :default)
    message_receiver.invoice_number ||= generate(format: format)
  end
end
