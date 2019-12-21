#!/bin/bash

#Programa simples para calculos de operacoes basicas para conhecer um pouco mais do shell

#Funcao para, baseado na operacao deseajda, retornar a resposta da operacao
function testarOperacoes {
	if [[ ${RESP} != "" ]]
	then
		fluxoSemArgumentos
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
			echo "erro"
			;;
	esac
}
#Funcao para receber os valores e a operacao
function fluxoSemArgumentos {
	read -p "Qual o primeiro valor? " VALOR1
	read -p "Qual o segundo valor? " VALOR2

	read -p "Qual a operacao?
	0 - Adicao
	1 - Subtracao
	2 - Multiplicacao
	3 - Divisao 
	OPCAO :    " OPERACAO
}
#Fluxo inicial
VALOR1=$1
OPERACAO=$2
VALOR2=$3

RESULT=""
AGAIN=true
#Rodar enquanto o usuario quiser
while [[ ${AGAIN} = true ]]  
do
	ERRO=true
	#Rodar enquanto tiver algum erro ( operacao invalida )
	while [[ ${ERRO} = true ]] 
	do
		ERRO=false
		if [[ $# -eq 0 ]]
		then
			RESP=""
			fluxoSemArgumentos
			RESP=`testarOperacoes`
		else
			RESP=`testarOperacoes`
		fi
		if [[ ${RESP} != "erro" ]]
		then
			echo ${RESP}
		else
			ERRO=true
			echo "Operacao Invalida"
		fi	
		
		#Se nao tiver a pasta resultados criada cria-la
		if [[ ! -d "resultados" ]] && [[ ${ERRO} = false ]]
		then
			mkdir resultados
		fi
		
		#Criar um arquivo com o historico das respostas
		cd resultados
		echo -e "${RESP}\n" >> resultados.txt
	done	
	echo -e "Deseja realizar outra operacao?\nDigite (s) para Sim e (n) para Nao"
	read RES
	if [[ ${RES} = "n" ]]
	then
		AGAIN=false
	fi
	cd ..
done
echo "Obrigado por usar a calculadora :)"
echo "Para ver o historico de uso de hoje e das vezes anteriores va ate a pasta resultados."
