defmodule Graphvix.Node do
  @doc """
  Create a new node with the given `attrs` and attach it to the active graph.

  Returns the map of the node with a unique id.

      iex> Node.new(label: "Start")
      %{ id: 1, attrs: [label: "Start"] }

  """
  @spec new(Keyword.t | nil) :: map
  def new(attrs \\ []) do
    GenServer.call(Graphvix.Graph, {:add_node, attrs})
  end

  @doc """
  Update the attributes of the node with the provided `node_id`.

  If `nil` is passed as a value in the `attrs` keyword list, it will remove
  the key entirely from the node's attributes.

      iex> n = Node.new(label: "Start")
      iex> Node.update(n.id, color: "blue", label: nil)

  """
  @spec update(pos_integer, Keyword.t) :: :ok
  def update(node_id, attrs) do
    GenServer.cast(Graphvix.Graph, {:update, node_id, attrs})
  end

  @doc """
  Deletes the node with the provided `node_id`.

  This will also remove any edges attached to the node, and remove it from
  any clusters it belongs to.

      iex> Node.delete(1)

  """
  @spec delete(pos_integer) :: :ok
  def delete(node_id) do
    GenServer.cast(Graphvix.Graph, {:remove, node_id})
  end

  @doc """
  Find the node in the graph that has the provided `node_id`.

  Returns the node, or `nil` if it is not found.

      iex> n = Node.new(label: "Start")
      iex> Node.find(n.id) #=> returns `n`

  """
  @spec find(pos_integer) :: map | nil
  def find(node_id) do
    GenServer.call(Graphvix.Graph, {:find, node_id})
  end
end
