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
end




arr1=[5,4,7,8,9,66,5,4,22,6,4,7,88]

arr = Tree.new(arr1)

arr.insert(10)

arr.delete(64)

arr.find(69)






