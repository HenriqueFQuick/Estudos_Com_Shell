#!/bin/bash

#Programa simples para calculos de operacoes basicas para conhecer um pouco mais do shell
VALOR1=$1
OPERACAO=$2
VALOR2=$3

RESULT=""
AGAIN=true
while [[ ${AGAIN} = true ]]  
do
	ERRO=true
	while [[ ${ERRO} = true ]] 
	do
		ERRO=false
		if [[ $# -eq 0 ]]
		then
			echo "Qual o primeiro valor?"
			read VALOR1
			echo "Qual o segundo valor?"
			read VALOR2
		
			echo "Qual a operacao?"
			echo -e "0 - Adicao\n1 - Subtracao\n2 - Multiplicacao\n3 - Divisao"
		    read OPERACAO	
	    	fi
		case ${OPERACAO} in
			"0" | "+")
				RESULT=${VALOR1}" + "${VALOR2}" = "$((VALOR1+VALOR2))
				echo "O resultado da adicao de ${VALOR1} com ${VALOR2} eh: $((VALOR1+VALOR2))"
				;;
			"1" | "-")
				RESULT=${VALOR1}" - "${VALOR2}" = "$((VALOR1-VALOR2))
				echo "O valor da subtracao de ${VALOR1} com ${VALOR2} eh: $((VALOR1-VALOR2))"
				;;
			"2" | "*")
				RESULT=${VALOR1}" * "${VALOR2}" = "$((VALOR1*VALOR2))
				echo "O valor da multiplicacao de ${VALOR1} com ${VALOR2} eh: $((VALOR1*VALOR2))"
				;;
			"3" | "/")
				RESULT=${VALOR1}" / "${VALOR2}" = "$((VALOR1/VALOR2))
				echo "O valor da divisao de ${VALOR1} com ${VALOR2} eh: $((VALOR1/VALOR2))"
				;;
			*)
				echo "Codigo de operacao invalida."
				ERRO=true
		esac
		if [[ ! -d "resultados" ]]
		then
			mkdir resultados
		fi
		cd resultados
		echo ${RESULT} > resultados.txt
	echo ${ERRO}
	done	
	echo -e  "Deseja realizar outra operacao?\nDigite (s) para Sim e (n) para Nao"
	read RES
	if [[ ${RES} = "n" ]]
	then
		AGAIN=false
	fi
done
echo "Obrigado por usar nosso programa :)"
