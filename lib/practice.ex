defmodule Practice do
  @moduledoc """
  Practice keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def double(x) do
    2 * x
  end

  def calc(expr) do
    # This is more complex, delegate to lib/practice/calc.ex
    Practice.Calc.calc(expr)
  end

  def factor(x) do
    y = Integer.to_string(x)
    {num, ""} = Integer.parse(y)
    factor_help(num, [], 2)
  end

  def factor_help(num, acc, divisor) do
    if divisor == num do
      factors = [divisor | acc]
      facts = Enum.reverse(factors)
      facts
   else
      if num == 2 do
        [2 | acc]
      else
        if rem(num, divisor) == 0 do
          factor_help(div(num,divisor), [divisor | acc], divisor)
        else
          factor_help(num, acc, divisor+1)
        end
      end
    end
  end

  # TODO: Add a palindrome? function.
  def palindrome(str) do
    reverse_str = String.downcase(str) |> String.reverse
    String.downcase(str) === reverse_str
  end
end
