class Strategy
    def initialize
        @visited = Hash.new
    end

    def sort(graph)
        vertices = graph.keys
        for vertex in vertices do
            @visited[vertex] = false
        end

        stack = Array.new
        for vertex in vertices do
            if @visited[vertex] == false
                _topological_sort(vertex, graph, stack)
            end
        end
        return stack
    end

    def _topological_sort(v, graph, stack)
        @visited[v] = true
        dependencies = graph[v]

        for i in 0..dependencies.size do
            dependency = dependencies[i]
            if @visited[v] == false
                _topological_sort(v, graph, stack)
            end
        end

        stack << v
    end
end
