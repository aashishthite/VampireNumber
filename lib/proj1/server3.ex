defmodule Project1.Vampire.Server3 do
	use GenServer

	def start_link(range) do
		GenServer.start_link(__MODULE__, range)
	end

	def init(range) do
		#IO.puts "#{inspect(range)}"
		start_children(range, 1, self())
		{:ok, []}
	end
	
	def start_children(range, step, pid) do
		chunks = Enum.chunk_every(range, step)
		tasks = for x <- chunks do
			Task.async(fn -> Project1.Vampire.FactorCalculator3.get_vampire_factors(x, pid) end)
		end

		Enum.map(tasks, &Task.await/1)
	end

	def handle_cast({:result, value}, state) do
		#IO.puts("#{inspect(state)}")
		{:noreply, [value|state]}
	end

	def handle_call(:result, _from, state) do
		{:reply, state, state}
	end
end