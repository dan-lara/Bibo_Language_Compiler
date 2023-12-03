all: bibo run_bibo_run 
CPPC=g++
FLEX=flex
BISON=bison
bibo:
	@echo "Bibo limpa lixo..."
	@rm -f lex lex.yy.c bibo.tab.c bibo.tab.h main.txt main.cpp a.out
	@echo "Bibo decora o dicionário..."
	@$(FLEX) bibo.l
	@echo "Bibo está aprendendo sintaxe..."
	@$(BISON) -d bibo.y --warnings=none
	@$(CPPC) lex.yy.c bibo.tab.c -std=c++17 -o lex

run_bibo_run:
	@echo "Detectando programa: $(file)..."
	@./lex $(file) main.txt main.cpp
	@echo "Programa DETECTADO! Tá na hora de rodar..."
	@$(CPPC) main.cpp
	@./a.out