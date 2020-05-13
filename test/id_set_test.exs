defmodule IdSetTest do
  use ExUnit.Case, async: true

  doctest IdSet

  describe "add" do
    test "add struct to set" do
      struct = struct_factory()

      assert IdSet.add([], struct) == [struct]
    end

    test "add nil doesn't change set" do
      struct = struct_factory()

      assert IdSet.add([struct], nil) == [struct]
    end

    test "adds 2 structs to set" do
      struct1 = struct_factory()
      struct2 = struct_factory(2)

      idset = IdSet.add([], struct1)
      idset = IdSet.add(idset, struct2)
      assert idset == [struct2, struct1]
    end

    test "adding duplicate structs only adds 1" do
      struct1 = struct_factory()
      struct2 = struct_factory()

      idset = IdSet.add([], struct1)
      idset = IdSet.add(idset, struct2)
      assert idset == [struct1]
    end

    test "lists with duplicates are uniqued" do
      struct1 = struct_factory()
      struct2 = struct_factory() 

      idset = IdSet.add([struct1, struct2], struct1)
      assert idset == [struct1]

      struct3 = struct_factory(2)
      struct4 = struct_factory(2) 

      idset = IdSet.add([struct1, struct2, struct3, struct4], nil)
      assert idset == [struct1, struct3]
    end

    test "lists with uniques are uniqued" do
      struct1 = struct_factory(1)
      struct2 = struct_factory(2) 
      struct3 = struct_factory(3) 
      struct4 = struct_factory(4) 
      struct5 = struct_factory(5) 
      struct6 = struct_factory(6) 
      struct7 = struct_factory(7) 
      struct8 = struct_factory(8) 
      struct9 = struct_factory(9) 
      struct10 = struct_factory(10)

      idset = IdSet.add([struct1, struct2, struct3, struct4, struct5, struct6, struct7, struct8, struct9, struct10], nil)
      assert idset == [struct10, struct9, struct8, struct7, struct6, struct5, struct4, struct3, struct2, struct1]
    end
  end

  describe "delete" do
    test "delete struct from empty set returns set" do
      struct = struct_factory()

      assert IdSet.delete([], struct) == []
    end

    test "delete struct from set returns empty set" do
      struct = struct_factory()

      assert IdSet.delete([struct], struct) == []
    end

    test "delete struct not in set doesn't affect set" do
      struct1 = struct_factory()
      struct2 = struct_factory(2)

      assert IdSet.delete([struct1], struct2) == [struct1]
    end

    test "deletes all instances of struct in set" do
      struct1 = struct_factory()
      struct2 = struct_factory(2)

      assert IdSet.delete([struct1, struct1, struct2], struct1) == [struct2]
    end

  end

  describe "member?" do
    test "returns false if list is empty" do
      struct = struct_factory()

      assert IdSet.member?([], struct) == false
    end

    test "returns false if struct is not in set" do
      struct1 = struct_factory()
      struct2 = struct_factory(2)

      assert IdSet.member?([struct1], struct2) == false
    end

    test "returns true if struct is in set" do
      struct = struct_factory()

      idset = IdSet.add([], struct)
      assert IdSet.member?(idset, struct) == true
    end
  end

  defp struct_factory(id \\ 1) do
    %{id: id}
  end
end
