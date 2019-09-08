defmodule Project1.Vampire.FactorCalculator2 do
	use GenServer

	def start_link(range) do
		{:ok, pid} = GenServer.start_link(__MODULE__, range)
		IO.puts "#{inspect(pid)}"
		{:ok, pid}
	end

	def init(range) do
		get_vampire_factors(range)
		{:ok, range}
	end


	def get_vampire_factors(range) do
		GenServer.cast(self(), {:get_vampire_factors_task, range})
	end

	def handle_cast({:get_vampire_factors_task, range}, state) do
		Enum.each(range, fn n ->
      		case vampire_factors(n) do
	        	[] -> {:cont}
	        	fangs -> IO.puts("#{n}:\t(#{inspect(fangs)})")
      		end
    	end)
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
