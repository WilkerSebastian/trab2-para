#!/bin/lua

local CXX = os.getenv("CXX") and os.getenv("CXX") or "gcc"

function ExecuteTest(target, size, core)

	local handle = io.popen(
	string.find(target, "seq") and
	"./bin/" .. target .. " " .. size or
	"./bin/" .. target .. " " .. size .. " " .. core
	)

	if handle ~= nil then

		handle:close()

		local log = io.open("performace.txt", "r")

		if log ~= nil then
				
				local time = log:read("*a")

				log:close()

				print(string.format("Teste matriz " .. size .. "x" .. size .. " [%ss]", time))

		else
			print("não deu pra analisar a performace")
		end

	end

end

function Compile(type)

	local FLAGS = "-O3"
	local SRC_PATH = "src/" .. type .. ".c"
	local BIN_PATH = "bin/" .. type

	if string.find(type, "par") then
		FLAGS = "-O3 -fopenmp"
	end

	os.execute(CXX .. " " .. FLAGS .. " " .. SRC_PATH .. " -o " .. BIN_PATH)
	
end

function Execute(type, matrix, threads)
	
	local BIN_PATH = "bin/" .. type

	os.execute(BIN_PATH .. " " .. matrix .. (threads and (" " .. threads) or ""))

end

if string.find(arg[1] and arg[1] or "", "par") or string.find(arg[1] and arg[1] or "", "seq") then

	Compile(arg[1])

	if arg[2] == "--run" then
		Execute(arg[1], arg[3], arg[4])
	end

elseif arg[1] == "all" then

	Compile("par")

	Compile("par2d")

	Compile("seq")

	Compile("seq2d")

elseif arg[1] == "test" then

	local title = "Teste " .. arg[2]

	print(title .. (string.find(arg[2], "par") and " com " .. arg[3] .. " threads\n" or "\n"))

	ExecuteTest(arg[2], "512", arg[3])

	ExecuteTest(arg[2], "1024", arg[3])

	ExecuteTest(arg[2], "2048", arg[3])

	ExecuteTest(arg[2], "3072", arg[3])
	
	ExecuteTest(arg[2], "3584", arg[3])

	ExecuteTest(arg[2], "4096", arg[3])
	
else
	print([[
Uso:
  make <comando> [opções]

Comandos disponíveis:

  all
      Compila todas as versões (seq, seq2d, par, par2d).

  seq
      Compila a versão sequencial (src/seq.c → bin/seq).
  seq --run <M>
      Compila e executa o binário sequencial para matriz de tamanho MxM.

  seq2d
      Compila a versão sequencial 2D (src/seq2d.c → bin/seq2d).
  seq2d --run <M>
      Compila e executa o binário seq2d para matriz de tamanho MxM.

  par
      Compila a versão paralela (src/par.c → bin/par) com OpenMP.
  par --run <M> <T>
      Compila e executa o binário paralelo para matriz MxM com T threads.

  par2d
      Compila a versão paralela 2D (src/par2d.c → bin/par2d) com OpenMP.
  par2d --run <M> <T>
      Compila e executa o binário par2d para matriz MxM com T threads.

  test seq
      Executa uma bateria de testes (512, 1024, 2048, 3072, 3584, 4096) para a versão seq.
  test seq2d
      Executa uma bateria de testes para a versão seq2d.
  test par <T>
      Executa uma bateria de testes para a versão par com T threads.
  test par2d <T>
      Executa uma bateria de testes para a versão par2d com T threads.

Descrição:
  Este CLI em Lua automatiza o processo de compilação, execução e teste
  de versões sequenciais e paralelas de algoritmos baseados em matrizes.
  Ele utiliza o compilador definido na variável de ambiente CXX (padrão: gcc)
  e gera logs de tempo de execução em 'performace.txt' para análise de desempenho.
]])
end

