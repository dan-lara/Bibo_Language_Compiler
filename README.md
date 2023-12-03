# Bibo

Este projeto foi desenvolvido para a matéria de Compiladores (ECOM06A) do curso de Engenharia de Computação na Universidade Federal de Itajubá (UNIFEI).

O trabalho tem como objetivo criar um compilador para uma linguagem desenvolvida pelo grupo. A implementação consiste num analisador léxico em formato Flex e um analisador sintático em formato Bison. O projeto tem como
base a linguagem C++.

Em comparação à primeira parte do trabalho, este possui as seguintes mudanças:

- "dielson " e "edilson" são, respectivamente início e fim;
- "retour" é return;
- Foi adicionada string;
- Foi adicionado encadeamento de entrada e saída.

## Exercícios do Beecrowd

É possível resolver estes exercícios utilizando a linguagem Bibo:

- [Crise de Energia](https://www.beecrowd.com.br/judge/pt/problems/view/1031)
- [LED](https://www.beecrowd.com.br/judge/pt/problems/view/1168)

## Ferramentas utilizadas

- [Flex]
- [Bison]

## Instalação

```bash
sudo apt-get install flex bison

sudo apt-get install make

git clone https://github.com/Daniel-Ferreira-Lara/Bibo_Language_Compiler.git

cd ./Bibo_Language_Compiler
# Gerar e compilar Tudo

make all file=arquivo.bibo

#Gerando compilador
make bibo

#Compilando arquivos
make run_bibo_run file=arquivo.bibo
```

## Como utilizar

Entrada:

```
>< x >> y .
```

Saída:

```
<>"Seu texto aqui".
```

If:

```
? (x < y):
  SEU CÓDIGO AQUI
;
```

Else:

```
!:
  SEU CÓDIGO AQUI
;
```

Else If:

```
!? (x):
  SEU CÓDIGO AQUI
;
```

While:

```
_8 (x):
  SEU CÓDIGO AQUI
;
```

For:

```
_4 (x = 10 . x>0 . i --):
  SEU CÓDIGO AQUI
;
```

Função:

```
int _nomeFuncao (int x, float, y, char z):
  SEU CÓDIGO AQUI
  retour 1.
;
```

## Autores

- [Daniel Ferreira Lara](https://github.com/Daniel-Ferreira-Lara)
- [Enzo Yukio Chinen](https://github.com/YukioZ25)
- [Matheus Siston Galdino](https://github.com/matgaldino)
