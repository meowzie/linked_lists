# frozen_string_literal: true

require 'pry-byebug'

# represents the full list
class LinkedList
  attr_accessor :head

  def initialize
    @head = nil
  end

  def append(value)
    node = Node.new(value)
    if @head
      tail_getter.next_node = node
    else
      @head = node
    end
  end

  def prepend(value)
    node = Node.new(value)
    node.next_node = @head
    @head = node
  end

  def tail_getter
    tail = @head
    tail = tail.next_node until tail.next_node.nil?
    tail
  end

  def before_tail_getter
    tail = @head
    tail = tail.next_node until tail.next_node.next_node.nil?
    tail
  end

  def size
    counter = 0
    return counter unless @head

    pointer = @head
    until pointer.nil?
      pointer = pointer.next_node
      counter += 1
    end
    counter
  end

  def at(index)
    pointer = @head
    index.times { pointer = pointer.next_node }
    pointer
  end

  def pop
    size >= 2 ? before_tail_getter.next_node = nil : @head = nil
  end

  def contains?(value)
    tail = @head
    tail = tail.next_node until tail.nil? || tail.value == value
    tail.nil? ? false : true
  end

  def find(value)
    return nil unless @head

    counter = 0
    return counter if @head.value == value

    pointer = @head
    until pointer.nil? || pointer.value == value
      pointer = pointer.next_node
      counter += 1
    end
    pointer.nil? ? nil : counter
  end

  def to_s
    index = 0
    output = String.new
    until at(index).nil?
      output << "( #{at(index).value} ) -> "
      index += 1
    end
    output << 'nil' if at(index).nil?
  end
end

# creates the nodes that go into a LinkedList
class Node
  attr_accessor :value, :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end
