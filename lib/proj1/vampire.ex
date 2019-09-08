defmodule Project1.Vampire.FactorCalculator do
	use GenServer

	def start_link(n) do
		{:ok, pid} = GenServer.start_link(__MODULE__, n)
		#IO.puts "#{inspect(pid)}"
		{:ok, pid}
	end

	def init(n) do
		get_vampire_factors(n)
		{:ok, n}
	end

	def get_vampire_factors(n) do
		GenServer.cast(self(), {:get_vampire_factors, n})
	end

	def handle_cast({:get_vampire_factors, n}, state) do

		result = vampire_factors(n)
		 if result != [] do
          IO.puts("#{n}:\t(#{inspect(result)})")
      	end
		{:noreply, state}
	end

	defp factor_pairs(n) do
	    first = trunc(n / :math.pow(10, div(char_len(n), 2)))
	    last = :math.sqrt(n) |> round
	    for i <- first..last, rem(n, i) == 0, do: {i, div(n, i)}
  	end

	 defp vampire_factors(n) do
	    if rem(char_len(n), 2) == 1 do
	      []
	    else
	      half = div(length(to_charlist(n)), 2)
	      sorted = Enum.sort(String.codepoints("#{n}"))
	      Enum.filter(factor_pairs(n), fn
	        {a, b} ->
	          	char_len(a) == half && char_len(b) == half &&
	            Enum.count([a, b], fn x -> rem(x, 10) == 0 end) != 2 &&
	            Enum.sort(String.codepoints("#{a}#{b}")) == sorted
	      end)
	    end
  	end

  	defp char_len(n), do: length(to_charlist(n))

end
