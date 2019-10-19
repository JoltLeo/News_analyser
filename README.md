# News Analyzer
Trabalho da disciplina de Linguagens de Programação (EEL670) ministrada pelo professor Miguel Elias na Universidade Federal do Rio de Janeiro (UFRJ).

## Objetivos

O trabalho tem como objetivo implementar um sistema para classificação de notícias baseada em análise de texto. O programa também classifica as notíias em sérias ou não-sérias baseado em um conjunto de métricas calculadas a partir da análise do texto daas notícias.

**Observações:**

* As notícias analisadas devem ser em arquivo texto

* As notícias devem ser em língua **portuguesa**

## Estrutura dos Diretórios

O diretório **news** contém as notícias que foram usadas para determinar as palavras mais frequentes em diversos subtópicos de notícias.

O diretório **src** contém um subdiretório **perl**. Esse subdiretório armazena os arquivos perl em fomarto (.pl). O subdiretório perl possui um diretório **modules**, que contém os módulos perl em formato (.pm).

## Arquivos
Algumas informações sobre os arquivos deste repositório:

* arquivo.txt, noticia.txt: arquivo contendo uma única notícia, usada para testar os módulos do sistema.

* blacklist.txt: arquivo contendo os autores e as fontes não-confiáveis. Futuramente, o usuário poderá adicionar ou remover pessoas através de uma interação com um gerenciador implementado em C++.

* curse_word.txt: arquivo padrão contendo as palavras de baixo calão para busca no texto. O programa permite que o usuário entre com um arquivo de palavras diferente. 

* menu.pl: arquivo contendo a implementação de uma interface que liga o usuário ao programa em Perl. Toda interação do usuário é feita através desse programa.

* check_artifacts.pm: arquivo contendo a implementação de uma função que verifica o uso de diversos artifícios não-sérios na notícia, como a relação entre carcateres maiúsculas e minúsculas, uso de *emoticons* e *emojis*, entre outros.

* check_blacklist.pm: arquivo contendo a implementação da função que verifica se o autor ou a fonte estão na blacklist.

* check_news_format.pm: arquivo contendo a implementação da função que verifica se o arquivo de notícias possui fonte e autor.

* classify_news.pm: arquivo contendo a implementação da função que classifica a notícia em séria ou nãao-séria.

* news_subject_classification.pm: arquivo contendo a implementação da função que classifica o assunto da notícia em uma entre cinco categorias: (i) economia; (ii) política; (iii) ciência; (iv) celebridades; (v) esportes;

## Requisitos

Para execução do programa, é necessário que o usuário possua a linguagem Perl insalada no ambiente de execução.

## Execução

Para executar o programa, o usuário deve executar:

` perl menu.pl `
