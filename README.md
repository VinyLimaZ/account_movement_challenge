# README

## What are all this sheeet?

Hello guys, I'm Vinicius and that's my solution to the problem you
brought to me :D

## Dependencies Versions
* Ruby version
2.6.6
* Postgres
12.3

# How to run?

- You'll need to install ruby and postgres on you machine;
- With the postgres installed run the command `createdb amc`
- Run `bundle install`
- The app do this, but if you find some errors with the database, run:
- - `sequel -m db/migrate/ postgres://localhost/amc`
- Finally: `ruby application.rb ACCOUNT_CSV_FILE TRANSACTIONS_CSV_FILE`
- - The system will try to pick this files on the application root directory, if
    is not there, navigate with unix [`points`](https://swcarpentry.github.io/shell-novice/02-filedir/index.html)!

# Do you want some specs?
- Run `sequel -m db/migrate/ postgres://localhost/amc_test` to create the test
    database
- Run `rspec`

## Some points about my solution:

- I tried to create an app without the rails, because it's a CLI app;
- I made following some SOLID rules and putting efforts in a modular
    application;
- I made some assumptions of the business rules to avoid lose time, but that's
    something that I really don't like to do on work, I start a task only if I
    had fully understand and I don't have nothing blocking me;
- I used the sequel to avoid bring things from Rails and to have a opportunity
    to use it (I never used it lol).

==============================================================

Enjoy and hire me, please (͡ ° ͜ʖ ͡ °)

==============================================================






# Desafio de Movimentação de Contas
## Objetivo
Desenvolver uma aplicação em linha de comando, em Ruby, que calcule o balanço da conta corrente dos clientes.
## Execução
A aplicação deve receber dois parâmetros na linha de comando: o nome do arquivo de contas e o nome do arquivo de transações.
Ex: ./contas.csv transacoes.csv
## Entrada
Os arquivos de entrada devem estar em formato CSV, sem cabeçalho, sem aspas e com campos delimitados por vírgula.
## Conteúdo dos arquivos
### Contas:
- Número da conta (inteiro)
- Saldo inicial da conta, em centavos de real (inteiro)
 Exemplo:  **123,13052** (Conta: 123, Saldo Inicial: R$ 130,52)
### Transações:
- Número da conta (inteiro)
- Valor da transação, em centavos de real (inteiro)
Uma transação com valor negativo é um débito na conta e uma transação com valor positivo é um depósito na conta.
Exemplo: **123,-5300** (Débito de R$ 53,00 na conta 123)
Exemplo: **123,350000** (Depósito de R$ 3.500,00 na conta 123)
### Cálculo do Saldo
O saldo da conta deve ser calculado a partir do saldo inicial, aplicando cada uma das transações relacionadas a esta conta. Os débitos devem reduzir o saldo da conta e depósitos devem aumentar o saldo da conta, na medida do valor da transação.
Uma conta pode assumir um valor negativo e não existe limite inferior para o saldo da conta. Entretanto, cada transação de débito que termina deixando o saldo da conta negativo implica uma multa de R$ 3,00 a ser descontada imediatamente. Esta multa é aplicada independentemente da conta estar ou não com saldo negativo antes da transação, porém se a transação for um depósito a multa não se aplica. As transações devem ser processadas na ordem em que são apresentadas no arquivo de entrada.
Exemplo:
- Criação da conta:
   - Saldo inicial da conta 123: R$ 100,00;
- Primeira movimentação:
   - Débito de R$ 103,00 da conta 123;
   -  Saldo atual da conta 123: R$ -6,00 (R$ 3,00 de multa aplicado);
- Segunda movimentação:
    - Débito de R$ 10,00 da conta 123;
    - Saldo atual da conta 123: R$ -19,00 (R$ 3,00 de multa aplicado);
## Saída
A saída deve ser exibida na tela (stdout). Deve ser uma lista de todas as contas no seguinte formato por linha:
- ID da conta (int);
- Saldo final da conta, em centavos de real (numérico).
  Ex: 123,37742 (Saldo final de R$ 377,42 na conta 123).
## Entrega do projeto
- Você deverá utilizar Ruby como linguagem de programação, e o uso de frameworks e gems ficará por sua conta!
- Seu projeto deverá ser entrege através do github, em um repositório público ou privado, na sua própria conta do github. Depois envie o link dele para nós. Se você fez eu um repositório privado, dê acesso de leitura para os usuários: *@noelrocha*, *@agramms*, *@silviolrjunior* e *@Marcovecchio*. Se não conseguir compartilhar para todos, compartilhe para pelo menos dois destes usuários.
- Sua solução deverá conter um arquivo README.md com as instruções de como executar o código
## Opcionais ( mas dá pontos extras! )
- Utilizar **Docker** / **Docker Compose** para que sua aplicação possa ser executada dentro de containeres, e o setup do ambiente seja facilitado.
- Se você utilizou gemas ou libs, explicar por que você decidiu utilizá-las.
- Sinta-se à vontade para utilizar banco de dados no projeto, para nos mostrar seu conhecimento no assunto, juntamente com ActiveRecord, migrations e o que mais desejar.
- Mostre a construção do seu projeto! Quanto mais commit melhor!!
