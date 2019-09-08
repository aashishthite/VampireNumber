defmodule Project1.Vampire.FactorCalculator3 do
	use GenServer

	def start_link(range) do
		{:ok, pid} = GenServer.start_link(__MODULE__, range)
		IO.puts "#{inspect(pid)}"
		{:ok, pid}
	end

	def init(range) do
		blah()
		{:ok, range}
	end

	def blah do
		IO.puts "Here"
		GenServer.call(self(), {:blah2})
	end

	def handle_call({:blah2}, _from, state) do
		IO.puts "Here"
		{:reply, state, state}
	end

end