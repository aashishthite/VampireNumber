defmodule Project1.Vampire.Supervisor3 do 

	def init(range) do
		{:ok, pid} = Project1.Vampire.Server3.start_link(range)
		#IO.puts "#{inspect(pid)}"
		Enum.each(GenServer.call(pid, :result), fn resultLine -> IO.puts resultLine end)
		{:ok, pid}
	end
	
end