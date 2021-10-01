require "strategy"

RSpec.describe Strategy do
    graph = {
        5 => [2, 0],
        4 => [0, 1],
        2 => [3],
        3 => [1],
        1 => [],
        0 => []
    }
    vertices = [0,1,2,3,4,5]
    subject { Strategy.new(vertices, graph) }

    describe "#sort" do
        it "should sort dag using topological sort" do
            expect(subject.sort()).to eq([5, 4, 2, 3, 1, 0])
        end
    end

    describe "#get_vertices" do
        it "should return the vertices" do
            expect(subject.get_vertices).to eq(vertices)
        end
    end

    describe "#add_vertex" do
        it "should add a vertices to vertex array" do
            expect {
                subject.add_vertex(6)
            }.to change { vertices }.from([0,1,2,3,4,5]).to([0,1,2,3,4,5,6])
        end
    end

    describe "#remove_vertex" do
        it "should remove a value from vertices and graphs if there isn't any dependency" do
            expect {
                subject.remove_vertex(6)
            }.to change { vertices }.from([0,1,2,3,4,5,6]).to([0,1,2,3,4,5])
        end

        it "should remove nothing and return :dependants_in_vertex due to dependency" do
            size = subject.get_vertices.size

            expect(subject.remove_vertex(3)).to eq(:dependants_in_vertex)
            expect(subject.get_vertices.size).to eq(size)
        end
    end

    describe "#get_dependants" do
        it "should return the values which depends on the given value" do
            expect(subject.get_dependants(4)).to eq([])
            expect(subject.get_dependants(0)).to eq([5, 4])
        end
    end

    describe "#has_edge" do
        it "should return true for 2" do
            expect(subject.has_edge 5,2).to eq(true)
        end

        it "should return false for 0" do
            expect(subject.has_edge 0,1).to eq(false)
        end
    end

    describe "#remove_edge" do
        it "should remove the edge for 5,2" do
            subject.remove_edge(5,2)
            expect(subject.get_dependants(2)).to eq(Array.new)
        end
    end

    describe "#check_cycle" do
        it "should return false since there isn't any cycle" do
            expect(subject.check_cycle).to eq(false)
        end
        
        it "should return true when 1,2 edge is added" do
            subject.add_edge(1, 2)
            expect(subject.check_cycle).to eq(true)
        end
        
        it "should return false since the cyclic edge is removed" do
            subject.remove_edge(1, 2)
            expect(subject.check_cycle).to eq(false)
        end
    end
end