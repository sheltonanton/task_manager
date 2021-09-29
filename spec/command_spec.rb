require "command"
RSpec.shared_examples "method definition check" do |method|
    it "should have a method '#{method.to_s}' defined" do
        expect(described_class.method_defined? method).to eq(true)
    end
end

RSpec.describe CLI do

    # it_behaves_like "method definition check", :instance
    # it_behaves_like "method definition check", :execute

    describe "#instance" do
        it "is a class method which returns same instance" do
            expect(described_class.instance).not_to be_nil
        end
    end
end