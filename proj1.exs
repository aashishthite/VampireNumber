[arg1,arg2] = Enum.map(System.argv, fn x -> String.to_integer(x) end)

Project1.Vampire.Supervisor3.init(arg1..arg2)