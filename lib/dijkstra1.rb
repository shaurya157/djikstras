require_relative 'graph'

# O(|V|**2 + |E|).
def dijkstra1(source)
  visited = {}
  possible_paths = {
    source => {cost: 0, last_edge: nil}
  }

  until possible_paths.empty?
    vertex = select_possible_path(possible_paths)

    visited[vertex] = possible_paths[vertex]
    possible_paths.delete(vertex)

    update_possible_paths(vertex, visited, possible_paths)
  end

  visited
end

# if error check this
def select_possible_path(possible_paths)
  vertex, data = possible_paths.min_by do |(vertex, data)|
    data[:cost]
  end

  vertex
end

def update_possible_paths(vertex, visited, possible_paths)
  path_to_vertex_cost = visited[vertex][:cost]

  vertex.out_edges.each do |edge|
    to_vertex = edge.to_vertex

    next if visited.has_key?(to_vertex)

    extended_path_cost = path_to_vertex_cost + edge.cost
    next if possible_paths.has_key?(to_vertex) &&
            possible_paths[to_vertex][:cost] <= extended_path_cost

    possible_paths[to_vertex] = {cost: extended_path_cost, last_edge: edge}
  end
end
