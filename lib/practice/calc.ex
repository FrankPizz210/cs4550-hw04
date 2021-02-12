defmodule Practice.Calc do


  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  def parse_operator(text) do
    {op, _} = text
    op
  end

  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    IO.puts expr
    expr_list = String.split(expr, " ")

    if length(expr_list) > 1 do
      num_list = get_nums(expr_list, [])
      op_list = get_operators(expr_list, [])

      sum = calc_help(num_list, op_list, 0)
      sum
    else
      {num, _} = Integer.parse(expr)
      num
    end
  end

  def get_operators(list, op_list) do
    operators = ["+", "-", "*", "/"]
    cur_obj = List.first(list)
    if cur_obj != nil do
      if cur_obj in operators do
        get_operators(list |> tl, [cur_obj | op_list])
      else
        get_operators(list |> tl, op_list)
      end
    else
      Enum.reverse(op_list)
    end
  end

  def get_nums(list, num_list) do
    operators = ["+", "-", "*", "/"]
    cur_obj = List.first(list)
    if cur_obj != nil do
      if !cur_obj in operators do
        get_nums(list |> tl, [parse_float(cur_obj) | num_list])
      else
        get_nums(list |> tl, num_list)
      end
    else
      Enum.reverse(num_list)
    end
  end

  def calc_help(num_list, op_list, sum) do
    if "*" in op_list do
      index = Enum.find_index(op_list,
        fn x -> x == "*" end
      )
      first_num = Enum.at(num_list, index)
      second_num = Enum.at(num_list, index+1)
      temp_sum = first_num * second_num
      list_update1 = List.delete_at(op_list, index)
      list_update2 = List.delete_at(num_list, index)
      list_update3 = List.delete_at(list_update2, index)
      list_update4 = List.insert_at(list_update3, index, temp_sum)
      calc_help(list_update4, list_update1, temp_sum)
    else
      if "/" in op_list do
        index = Enum.find_index(op_list,
          fn x -> x == "/" end
        )
        first_num = Enum.at(num_list, index)
        second_num = Enum.at(num_list, index+1)
        temp_sum = first_num / second_num
        list_update1 = List.delete_at(op_list, index)
        list_update2 = List.delete_at(num_list, index)
        list_update3 = List.delete_at(list_update2, index)
        list_update4 = List.insert_at(list_update3, index, temp_sum)
        calc_help(list_update4, list_update1, temp_sum)
      else
        if "+" in op_list do
          index = Enum.find_index(op_list,
            fn x -> x == "+" end
          )
          first_num = Enum.at(num_list, index)
          second_num = Enum.at(num_list, index+1)
          temp_sum = first_num + second_num
          list_update1 = List.delete_at(op_list, index)
          list_update2 = List.delete_at(num_list, index)
          list_update3 = List.delete_at(list_update2, index)
          list_update4 = List.insert_at(list_update3, index, temp_sum)
          calc_help(list_update4, list_update1, temp_sum)
        else
          if "-" in op_list do
            index = Enum.find_index(op_list,
              fn x -> x == "-" end
            )
            first_num = Enum.at(num_list, index)
            second_num = Enum.at(num_list, index+1)
            temp_sum = first_num - second_num
            list_update1 = List.delete_at(op_list, index)
            list_update2 = List.delete_at(num_list, index)
            list_update3 = List.delete_at(list_update2, index)
            list_update4 = List.insert_at(list_update3, index, temp_sum)
            calc_help(list_update4, list_update1, temp_sum)
          else
            sum
          end
        end
      end
    end
  end
end
