# Trabalho de Programação Paralela 2

Este repositório tem o código do trabalho de programação paralela 2, focado na otimização da multiplicação de matrizes (C=AxB) usando OpenMP. O projeto compara quatro implementações para analisar o impacto do paralelismo e da localidade de dados (cache):

Sequencial (seq): Versão padrão com 3 loops (i,j,k).

Sequencial 2D (seq2d): Versão sequencial com 6 loops, otimizada para cache usando particionamento em blocos.

Paralelo 1D (par): Versão com 3 loops, paralelizada com OpenMP no loop externo i.

Paralelo 2D (par2d): Versão com 6 loops, paralelizada com OpenMP para otimização de cache e concorrência.

---
### Pré-requisitos

Para compilar e executar este projeto, você precisará ter os seguintes pacotes instalados no seu sistema:

GCC: O compilador padrão para C.

Lua: O interpretador para executar o script de build.

OpenMP: Não é uma instalação separada, mas uma funcionalidade do compilador. O gcc (com a flag -fopenmp) já inclui o suporte necessário.

---
### Como Usar

Todas as ações são executadas através do script make.lua. O formato geral do comando é: lua make.lua [comando] [opções...]

#### Compilação
Compilar todas as quatro versões de uma vez:

```bash
lua make.lua all
```

Ou compilar individualmente:

```bash
# Sequencial
lua make.lua seq

# Sequencial 2D 
lua make.lua seq2d

# Paralelo
lua make.lua par

# Paralelo 2D
lua make.lua par2d
```

#### Execução Simples

Executar uma versão sequencial para uma matriz de tamanho MxM:

```bash
lua make.lua seq --run <M>
``` 

Executar uma versão paralela (1D ou 2D) para uma matriz MxM com T threads:

```bash
lua make.lua par --run <M> <T>
```

```bash
lua make.lua par2d --run <M> <T>
```

#### Bateria de Testes

A suíte de testes executa o programa com várias entradas de matriz (512, 1024, 2048, etc.) e exibe o tempo de execução registrado no arquivo performace.txt.

Testar a versão sequencial:

```bash
lua make.lua test seq
```

Testar a versão sequencial 2D:


```bash
lua make.lua test seq2d
```

Testar a versão paralela 1D com T threads:

```bash
lua make.lua test par <T>
```

Testar a versão paralela 2D com T threads:

```bash
lua make.lua test par2d <T>
```

Saída esperada (exemplo):

```bash
Teste par2d com 10 threads

Teste matriz 512x512 [0.123456s]
Teste matriz 1024x1024 [0.987654s]
Teste matriz 2048x2048 [7.123456s]
...