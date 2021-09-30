require "strategy"

RSpec.describe Strategy do
    describe "#sort" do
        it "should sort dag using topological sort" do
            graph = {
                5 => [2, 0],
                4 => [0, 1],
                2 => [3],
                3 => [1],
                1 => [],
                0 => []
            }

            expect(subject.sort(graph)).to eq([5, 4, 2, 3, 1, 0])
        end
    end
end