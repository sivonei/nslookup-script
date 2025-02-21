#!/bin/bash

# Verifica se o comando nslookup está disponível
if ! command -v nslookup &> /dev/null; then
    echo "Erro: o comando 'nslookup' não está disponível. Por favor, instale-o e tente novamente."
    exit 1
fi

# Solicita o domínio e o servidor DNS ao usuário
read -p "Por favor, insira o(s) domínio(s) (separados por espaço): " domain_input
read -p "Por favor, insira o servidor DNS (pressione Enter para usar o DNS padrão): " dns_server

# Verifica se pelo menos um domínio foi inserido
if [ -z "$domain_input" ]; then
    echo "Nenhum domínio foi inserido. Uso: $0 <domínio1> <domínio2> ..."
    exit 1
fi

# Converte a entrada do usuário em uma lista de argumentos
set -- $domain_input

# Variável para armazenar os resultados
log_output=""

# Itera sobre cada domínio fornecido
for domain in "$@"; do
    echo "Consultando DNS para: $domain"
    
    # Executa nslookup e captura a saída
    if [ -z "$dns_server" ]; then
        nslookup_output=$(nslookup "$domain" 2>&1)
    else
        nslookup_output=$(nslookup "$domain" "$dns_server" 2>&1)
    fi
    
    # Verifica se o nslookup teve sucesso
    if [ $? -eq 0 ]; then
        echo "Resultado do nslookup para $domain:"
        echo "$nslookup_output"
        log_output+="Resultado do nslookup para $domain:\n$nslookup_output\n"
    else
        echo "Erro ao consultar $domain"
        echo "$nslookup_output"
        log_output+="Erro ao consultar $domain:\n$nslookup_output\n"
    fi
    
    echo "-----------------------------------"
    log_output+="-----------------------------------\n"
done

# Salvar o resultado em um arquivo de log
read -p "Deseja salvar o resultado em um arquivo de log? (s/n): " save_log

if [ "$save_log" == "s" ]; then
    # Obtém a data e hora atuais %Y-%m-%d
    current_date=$(date +"%d-%m-%Y_%H-%M-%S")
    log_file="nslookup_log_$current_date.txt"
    
    # Salva o resultado no arquivo de log
    echo -e "$log_output" > "$log_file"
    echo "Resultado salvo em $log_file"
fi