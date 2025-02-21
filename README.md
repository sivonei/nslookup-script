
# Script de Consulta DNS em Linux

Este é um script Bash simples para realizar consultas DNS usando o comando `nslookup`. Ele permite consultar múltiplos domínios de uma vez e salvar os resultados em um arquivo de log.

## Como Usar

# 1. Clone o repositório:

git clone https://github.com/seu-usuario/nslookup-script-linux.git

# Navegue até a pasta do projeto:
cd nslookup-script-linux

# Torne o script executável:
chmod +x nslookup.sh

# Execute o script:
./nslookup.sh

# Siga as instruções na tela para inserir os domínios e o servidor DNS.

<!-- Funcionalidades
1 Consulta DNS para múltiplos domínios.

2 Suporte a servidores DNS personalizados.

3 Salvamento dos resultados em um arquivo de log. -->

# Exemplo de Uso:
$ ./nslookup.sh
Por favor, insira o(s) domínio(s) (separados por espaço): google.com example.com
Por favor, insira o servidor DNS (pressione Enter para usar o DNS padrão): 8.8.8.8