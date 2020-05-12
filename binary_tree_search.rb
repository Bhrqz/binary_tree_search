require "pry"

module Comparable
  #Dont know what to do here.... yet
end


class Node
  attr_accessor :left_c, :right_c, :data
  
  def initialize(data=nil)
    @data = data
    @left_c =nil
    @right_c =nil
  end
  
end

class Tree
  attr_accessor :root

  def initialize (arr)
    @arr = arr
    @root = build_tree(arr)
  end

  def build_tree(arr)
    
    
    arr.uniq!

    pp arr

    root = Node.new(arr[arr.length/2])
    arr.each do |d| 
      d.to_i
      bilding(root, d)
    end
    return root

    
  end

#if DATA is Greater than... goes Rigth
#if DATA is lower than... goes Left
#if DATA is equal than... no, that never would happen in this code

  def bilding(node, d)
    if d > node.data
      if node.right_c
        bilding(node.right_c, d)
      else
        node.right_c = Node.new(d)
      end
    elsif d < node.data
      if node.left_c
        bilding(node.left_c, d)
      else
        node.left_c = Node.new(d)
      end
    end
  end

  def insert(value)
    node = @root
    def get (node, value)
      if value > node.data
        
        if node.right_c
          get(node.right_c, value)
        else
          node.right_c = Node.new(value)
        end
      elsif value < node.data
        if node.left_c
          get(node.left_c, value)
        else
          node.left_c = Node.new(value)
        end
      end
    end
    get(node, value)
  end


  def delete (value)
    node = @root
    parent = @root

    while node
     
      if node.data.to_i < value
        parent = node
        node = node.right_c
        
      elsif node.data.to_i > value
        parent = node
        node = node.left_c

        # ERASING LEAF NODES
      elsif node.data == value && node.left_c == nil && node.right_c == nil 
        if parent.data > value
          parent.left_c = nil
          node = node.left_c
        elsif parent.data < value
          parent.right_c = nil
          node = node.right_c
        end 

        #ERASING NODES with just ONE CHILD in the LEFT
      elsif node.data == value && node.left_c && node.right_c ==nil 
        parent.left_c = node.left_c
        node = node.right_c
      
        #ERASING nodes with just ONE CHILD in the RIGHT
      elsif node.data == value && node.left_c == nil && node.right_c
        parent.right_c = node.right_c
        node = node.right_c

        #Erasing NODEs with TWO children
      elsif node.data == value && node.left_c && node.right_c
        hold = node.right_c
        target = node
        while hold
          if !hold.left_c
            target = hold
            delete(target.data)
            node.data = target.data
            break
          elsif hold.left_c
              hold = hold.left_c
          end
        end
      end
    end
  end

  def find(value)
    node = @root
    while node
      if node.data < value && node.right_c
        node = node.right_c
      elsif node.data > value && node.left_c
        node = node.left_c
      elsif node.data == value
        puts "This is the node with value #{value}: #{node}"
        break
      elsif (node.data > value && node.left_c==nil) || (node.data < value && node.left_c==nil)
        puts "There is no node with value of #{value} in this Tree"
        break
      end 
    end
  end

  def level_order 
    queue = []
    result = []
    node = @root

    #starting putting the root in queue
    queue.push(node)
    while node
      
    #check if got children and put them in the queue from left to right
      queue.push(node.left_c) if node.left_c
      queue.push(node.right_c) if node.right_c 
            
    #when finished the level push the nodes  into the Array and yield them (ha!)
      result.push(queue.shift.data)
      puts yield result.last if block_given?
    #do it again
      node = queue.first
    end    
    pp result if !block_given?
  end

  def inorder(value=root)
    #get the lower node
    result = []
    node = value
      

    recursive_in(node, result)
     
    pp result
    result.each {|node| yield node}
    
  end

  def recursive_in(node, result)
    return result unless node
    recursive_in(node.left_c, result) if node.left_c
    result << node.data
    recursive_in(node.right_c, result) if node.right_c
  end

  def preorder(value=root)
    result = []
    node = value


    recursive_pre(node, result)

    pp result
    result.each {|node| yield node}

  end

  def recursive_pre(node, result)
    return result unless node
    result << node.data
    recursive_pre(node.left_c, result) if node.left_c
    recursive_pre(node.right_c, result) if node.right_c
  
  end

  def postorder(value=root)
    result = []
    node = value
    recursive_post(node, result)
    pp result
    result.each {|node| yield node}

  end

  def recursive_post(node, result)
    return result unless node
    recursive_post(node.left_c, result) if node.left_c
    recursive_post(node.right_c, result) if node.right_c
    result << node.data
  end

  def depth(value, node = @root)
    depth = 0
    while node
      if node.data < value && node.right_c
        node = node.right_c
        depth += 1
      elsif node.data > value && node.left_c
        node = node.left_c
        depth += 1
      elsif node.data == value
        pp depth
        return depth

      elsif (node.data > value && node.left_c==nil) || (node.data < value && node.left_c==nil)
        puts "There is no node with value of #{value} in this Tree"
        break
      end 
    end
  end

  def balanced?
    node = @root
    a_node = node.left_c
    b_node = node.right_c

    left_depth = leaf_node(a_node)
    right_depth = leaf_node(b_node)

    if (depth(left_depth.data, a_node) - depth(right_depth.data, b_node) < 1) || (depth(left_depth.data, a_node) - depth(right_depth.data, b_node) > -1)
      puts "It is balanced"
    else
      puts "It is not balanced"
    end
  end

  def leaf_node(node)
    return node if !node.left_c && !node.right_c
    leaf_node(node.left_c) if node.left_c
    leaf_node(node.right_c) if node.right_c
  end

  def rebalance!
    array = level_order()
    pp "array es #{array}"
    tree = build_tree(array)
    pp tree
   
  end

end




arr1=[5,4,7,8,9,66,5,4,22,6,4,7,88]

arr = Tree.new(arr1)

arr.insert(10)

arr.delete(64)

arr.find(69)

#arr.level_order {|node| "I'm yielding the data of this node which is: #{node} "}

#arr.inorder { |node| puts "I am yieldin the node of value #{node} "}

#arr.preorder { |node| puts "I am yieldin the node of value #{node} "}

#arr.postorder { |node| puts "I am yieldin the node of value #{node} "}
 
#arr.depth(66)

#arr.balanced?

arr.rebalance!


