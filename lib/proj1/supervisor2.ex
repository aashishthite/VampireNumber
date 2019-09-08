defmodule Project1.Vampire.Supervisor2 do 
	use Supervisor

	def start_link do
		Supervisor.start_link(__MODULE__, [])
	end

	def init(_) do
		chunks = Enum.chunk_every(1000..2000, 100)
		children = Enum.map(chunks, fn chunk -> 
			worker(Project1.Vampire.FactorCalculator2,  [chunk], [id: List.first(chunk), restart: :permanent]) end)
		
	
		supervise(children, strategy: :one_for_one)
		
	end


end