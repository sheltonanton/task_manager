class Strategy
    def initialize(vertices, graph)
        @visited = Hash.new
        @vertices = vertices
        @graph = graph
    end

    def sort()
        graph = @graph
        vertices = graph.keys
        for vertex in vertices do
            @visited[vertex] = false
        end

        stack = Array.new
        for vertex in vertices do
            if @visited[vertex] == false
                _topological_sort(vertex, stack)
            end
        end
        return stack
    end

    def _topological_sort(v, stack)
        @visited[v] = true
        graph = @graph
        dependencies = graph[v]

        for i in 0..dependencies.size do
            dependency = dependencies[i]
            if @visited[v] == false
                _topological_sort(v, stack)
            end
        end

        stack << v
    end

    def check_cycle
        return false
    end

    def get_vertices()
        return [*@vertices]
    end

    def get_vertex(id)
        return @vertices.find { |vertex| _value(vertex) == id }
    end

    def get_dependants(a)
        @graph.inject(Array.new) { |list, (vertex, dependants)| 
            list << vertex if dependants.include?(a)
            list
        }
    end

    def add_vertex(a)
        @vertices << a
        @graph[a] = Array.new
    end

    def remove_vertex(id, forced=false)
        if forced
            vertex = get_vertex(id)
            @graph.delete(vertex)
            @graph.values.each do |dependants|
                dependants.delete(vertex)
            end
        else
            vertex = get_vertex(id)
            has_edge = @graph.values.any? { |edges| edges.include? vertex }
            if has_edge
                return :dependants_in_vertex
            end
        end

        @vertices.delete(
            @vertices.find do |vertex|
                _value(vertex) == id
            end
        )
    end

    def add_edge(a, b)
        if @graph[a].include? b
            return :already_added
        end
        @graph[a] = b
        has_cycle = check_cycle
        return :has_cycle if has_cycle
    end

    def remove_edge(a, b)
        @graph[a].delete(b) if @graph[a].include? b
    end

    def has_edge(a, b)
        return @graph[a].include?(b)
    end

    def _value(v)
        return v.id if v.respond_to?(:id)
        return v
    end
end
