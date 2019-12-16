#Programa simples para calculos de operacoes basicas para conhecer um pouco mais do shell

#Funcao para, baseado na operacao deseajda, retornar a resposta da operacao
function testarOperacoes($RESP, $OPERACAO, $VALOR1, $VALOR2) {
	if ($RESP -ne "") { $OPERACAO, $VALOR1, $VALOR2 = fluxoSemArgumentos }

	$RESP = switch -regex ($OPERACAO) {
		"0|\+" {
			$RESULT = "$VALOR1 + $VALOR2 = $($VALOR1 + $VALOR2)"
			"O resultado da adicao de $VALOR1 com $VALOR2 eh: $($VALOR1 + $VALOR2)"
		}
		"1|-" {
			$RESULT = "$VALOR1 - $VALOR2 = $($VALOR1 - $VALOR2)"
			"O valor da subtracao de $VALOR1 com $VALOR2 eh: $($VALOR1 - $VALOR2)"
		}
		"2|\*" {
			$RESULT = "$VALOR1 * $VALOR2 = $($VALOR1 * $VALOR2)"
			"O valor da multiplicacao de $VALOR1 com $VALOR2 eh: $($VALOR1 * $VALOR2)"
		}
		"3|/" {
			$RESULT = "$VALOR1 / $VALOR2 = $($VALOR1 / $VALOR2)"
			"O valor da divisao de $VALOR1 com $VALOR2 eh: $($VALOR1 / $VALOR2)"
		}
		default { "erro" }
	}
	
	return $RESP, $RESULT, $VALOR1, $VALOR2
}
#Funcao para receber os valores e a operacao
function fluxoSemArgumentos {
	$VALOR1 = (read-host "Digite o primeiro valor") -as [int]
	$VALOR2 = (read-host "Digite o segundo valor") -as [int]

	$OPERACAO = read-host "Qual a operacao?
0 - Adicao
1 - Subtracao
2 - Multiplicacao
3 - Divisao 
OPCAO"

	return $OPERACAO, $VALOR1, $VALOR2
}
#Fluxo inicial
$VALOR1 = $Args[0] -as [int]
$OPERACAO = $Args[1]
$VALOR2 = $Args[2] -as [int]

$RESULT = ""
$AGAIN = $true
$RESP = ""
#Rodar enquanto o usuario quiser
while ($AGAIN)  
{
	$ERRO = $true
	#Rodar enquanto tiver algum erro ( operacao invalida )
	while ($ERRO)
	{
		$ERRO = $false
		if ($Args.Count -eq 0)
		{
			$RESP = ""
			$OPERACAO, $VALOR1, $VALOR2 = fluxoSemArgumentos
		}
		
		$RESP, $RESULT, $VALOR1, $VALOR2 = testarOperacoes $RESP $OPERACAO $VALOR1 $VALOR2
		$Args = @()  # Reseta Args após o primeiro uso
		
		if ($RESP -ne "erro") { echo $RESP }

		else
		{
			$ERRO = $true
			echo "Operacao Invalida"
		}
		
		#Se nao tiver a pasta resultados criada cria-la
		if (-not (Test-Path resultados -PathType Container) -and -not $ERRO)
		{
			mkdir resultados
		}
		
		#Criar um arquivo com o historico das respostas
		cd resultados
		echo "$RESP" >> resultados.txt
		cd ..
	}

	$RES = read-host "Deseja realizar outra operacao?`nDigite (s) para Sim e (n) para Nao"
	$AGAIN = $RES -ne "n"
}

echo "Obrigado por usar nosso programa :)"
