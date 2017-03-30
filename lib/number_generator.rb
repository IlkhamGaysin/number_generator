class NumberGenerator
  VERSION = "0.1.0".freeze

  attr_reader :invoice

  def initialize(invoice)
    @invoice = invoice
  end

  def generate(format: :default)
    case format
      when :date
        [invoice.created_at.strftime("%Y%m%d"),
         generate].join('-')
      else
        '%.5d' % invoice.position
    end
  end

  def generate!(format: :default)
    invoice.invoice_number ||= generate(format: format)
  end
end
