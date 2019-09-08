defmodule Project1.Vampire.Supervisor do 
	use Supervisor

	def start_link do
		Supervisor.start_link(__MODULE__, [])
	end

	def init(_) do
		children = Enum.map(1000..2000, fn num -> 
			worker(Project1.Vampire.FactorCalculator,  [num], [id: num, restart: :permanent]) end)
		
	
		supervise(children, strategy: :one_for_one)
	end
end