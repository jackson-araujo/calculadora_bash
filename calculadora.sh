# Verifica se o programa 'awk' existe.
awk -V 2&> /dev/null

# Caso o resultado da pesquisa acima seja falso, executa a instalação do programa awk.
if (( $? != 0 )); then sudo apt install gawk -y && clear; fi

# Execução do laço contínuo para exibição do menu do script (calculadora). Exceto se digitar um argumento inválido ou zero para sair.
while true
do
	# Função recebe os dois valores numéricos e realiza a operação de soma.
	soma () {
		local NUMERO1=$1
		local NUMERO2=$2
		RESULTADO=$(($NUMERO1+$NUMERO2))
		echo "SOMA -> $NUMERO1 + $NUMERO2 = $RESULTADO"
	}
	
	# Função recebe os dois valores numéricos e realiza a operação de subtração.
	subtracao () {
		local NUMERO1=$1
		local NUMERO2=$2
		RESULTADO=$(($NUMERO1-$NUMERO2))
		echo "SUBTRACAO -> $NUMERO1 - $NUMERO2 = $RESULTADO"
	}

	# Função recebe os dois valores numéricos e realiza a operação de multiplicação.
	multiplicacao () {
		local NUMERO1=$1
		local NUMERO2=$2
		RESULTADO=$(($NUMERO1*$NUMERO2))
		echo "SOMA -> $NUMERO1 * $NUMERO2 = $RESULTADO"
	}
	
	# Função recebe os dois valores numéricos e realiza a operação de divisão.
	divisao () {
		local NUMERO1=$1
		local NUMERO2=$2
	
		# Verificando se o divisor é igual a zero antes de dividir
		if [ "$NUMERO2" -eq 0 ]
		then
			echo "Erro: Divisor é igual a zero, divisão não é possível."
		else
			RESULTADO=$(awk -v dividendo="$NUMERO1" -v divisor="$NUMERO2" 'BEGIN { printf "%.2f", dividendo / divisor }')
			echo "DIVISAO -> $NUMERO1 / $NUMERO2 = $RESULTADO"
		fi
	}
	
	# Menu do Script.	
	echo "----------------------- Calculadora -----------------------"
	echo
	echo "Escolha o Operador ou (0) para sair:"
	echo
	echo "(+) Soma; (-) Subtração; (*) Multiplicação; (/) Divisão."
	
	# Realiza a leitura do operador.
	read -p ":" OPERADOR
	
	# Se o operador digitado for 0(zero) o script é encerrado.
	if [ "$OPERADOR" = '0' ]; then echo "Sair" && exit; fi
	
	# Se o operador diferente de: +, -, *, /. O script é encerrado.
	if [ "$OPERADOR" != '+' ] && [ "$OPERADOR" != '-' ] && [ "$OPERADOR" != '*' ] && [ "$OPERADOR" != '/' ]; then echo "Operador não permitido. Acesse novamente!" && exit; fi
	
	# Efetua a leitura do primeiro número digitado para realizar a operação.
	echo "Primeiro Número:"
	read "NUM1"
	echo
	
	# Se o argumento 1 digitado não for um número, o script é encerrado.
	if ! [[ "$NUM1" =~ ^[0-9]+$ ]]; then echo "O argumento ($NUM1) não é um número. Acesse novamente!" && exit; fi

	# Efetua a leitura do segundo número digitado para realizar a operação.
	echo "Segundo Número:"
	read "NUM2"
	echo
	
	# Se o argumento 2 digitado não for um número, o script é encerrado.
	if ! [[ "$NUM2" =~ ^[0-9]+$ ]]; then echo "O argumento ($NUM2) não é um número. Acesse novamente!" && exit; fi

	# Verifica o operador e executa a função correspondente e seus argumentos.
	if [ "$OPERADOR" = '+' ]; then soma "$NUM1" "$NUM2"; fi
	if [ "$OPERADOR" = '-' ]; then subtracao "$NUM1" "$NUM2"; fi
	if [ "$OPERADOR" = '*' ]; then multiplicacao "$NUM1" "$NUM2"; fi
	if [ "$OPERADOR" = '/' ]; then divisao "$NUM1" "$NUM2"; fi

done	

# Sair do Script
exit
