#/bin/bash
# Autor: Smith Braz
# Data: 16/01/2025
# github: https://github.com/thiagosmith

rm meta.txt 2> /dev/null # limppa a pasta antes de iniciar a execucao
rm -rf *$2 # apaga arquivos para nao conflitar os resultados
echo "Realizando a busca"
lynx --dump "www.google.com/search?&q=site:$1+ext:$2" | grep $2 | cut -d "=" -f2 | egrep -v "sit|google" | grep http | cut -d ";" -f1 | sed 's/...$//' > meta.txt # realiza o google dork e salva o link em arquivo
echo "" # pula uma linha
echo "Arquivos encontrados"
cat meta.txt # ler a lista de links baixados
echo ""
echo "Fazendo o download dos arquivos"
for site in $(cat meta.txt); do wget $site;done # faz um for na lista para realizar o download
echo ""
echo "Examinando os metadados" 
exiftool *$2 2>/dev/null # analisa os metadados
echo ""
echo "Apagando os arquivos baixados"
rm -rf *$2 2>/dev/null # apaga os arquivos baixados
rm meta.txt 2>/dev/null # apaga a lista
