require "spec_helper"

describe NumberGenerator do
  describe "Gem version" do
    it "has a version number" do
      expect(NumberGenerator::VERSION).to eq "0.1.0"
      expect(NumberGenerator::VERSION).not_to be nil
    end
  end

  describe "Instance methods" do
    let(:dummy) { OpenStruct.new(created_at: Time.now, position: 1) }
    let(:generator) { NumberGenerator.new(dummy) }

    before do
      Timecop.freeze(Time.local(2017, 03, 31))
    end

    after do
      Timecop.return
    end

    describe "#generate" do
      context "without defined format at all" do
        it "returns numbers without date as prefix" do
          result = generator.generate

          expect(result).to eq("00001")
        end
      end

      context "with defined format as date" do
        it "returns numbers with date as prefix" do
          result = generator.generate(format: :date)

          expect(result).to eq("20170331-00001")
        end
      end

      it "calls generate once" do
        expect(generator).to receive(:generate).once.and_call_original

        generator.generate
      end

      it "calls generate twice" do
        expect(generator).to receive(:generate).twice.and_call_original

        generator.generate(format: :date)
      end
    end

    describe "#generate!" do
      context "without defined format at all" do
        it "returns numbers without date as prefix" do
          result = generator.generate

          expect(result).to eq("00001")
        end
      end

      context "when invoice_number present" do
        it "calls generate twice and set invoice_number twice" do
          expect(generator).to receive(:generate).with(format: :default).twice
          expect(dummy).to receive(:invoice_number=).and_return("00001").twice

          generator.generate!
          generator.generate!
        end
      end

      context "when invoice_number absence" do
        let(:dummy) { OpenStruct.new(created_at: Time.now, invoice_number: rand(1..10)) }

        it "doesn't call generate and set invoice_number" do
          expect(generator).to receive(:generate).with(format: :default).exactly(0).times
          expect(dummy).to receive(:invoice_number=).exactly(0).times

          generator.generate!
        end
      end

      context "with defined format as date" do
        it "returns numbers with date as prefix" do
          result = generator.generate!(format: :date)

          expect(result).to eq("20170331-00001")
        end
      end
    end
  end
end
