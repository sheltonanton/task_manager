require "singleton"

# on demand loading not yet enabled

RSpec.describe Singleton do
    describe "#new" do
        it "is a private method and cannot be called" do
            expect {
                Singleton.new
            }.to raise_error(NoMethodError)
        end
    end

    describe "#instance" do
        it "should not be nil" do
            expect(Singleton.instance).to_not be_nil
        end
        
        it "is a class method which returns same instance" do
            instance_1 = Singleton.instance
            instance_2 = Singleton.instance

            expect(instance_1 == instance_2).to eq(true)
        end
    end
end