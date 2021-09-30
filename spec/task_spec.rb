require "task"
require "task_group"

RSpec.shared_examples "method definition check" do |method|
    it "should have a method '#{method.to_s}' defined" do
        expect(described_class.method_defined? method).to eq(true)
    end
end

RSpec.describe Task do
    describe ".send" do
        it "should send description message" do
            description = 'task description'
            subject.send("description=", description)
            expect(subject.description).to eq(description)
        end
    end
end
