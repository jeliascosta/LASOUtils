#!/bin/sh
#adaptação de http://cassidy.codes/blog/2017/04/25/ffmpeg-frames-to-gif-optimization/
#http://blog.pkh.me/p/21-high-quality-gif-with-ffmpeg.html

#Autor Jônathan Elias
#Script para converter todos os videos da pasta atual para GIFs otimizados para o projeto LIBREASOffice

dimensao_corte="290:290" # largura:altura (pixels)
posicao_inicial_corte="210:35" # pixels a partir da esquerda : pixels a partir do topo
quadros_por_segundo=10
dimensao_arquivo_saida="190:190" # largura:altura (pixels)

palette="/tmp/palette.png"
filters="crop=$dimensao_corte:$posicao_inicial_corte,fps=$quadros_por_segundo,scale=$dimensao_arquivo_saida:flags=lanczos"
mkdir -p GIFs
for video in *.avi *.mp4 *.mpg #lista de extensoes de videos a serem consideradas
do
	ffmpeg -hide_banner -loglevel quiet -i "$video" -vf "palettegen=stats_mode=diff" -y $palette
	ffmpeg -hide_banner -loglevel quiet -i "$video" -i $palette -lavfi "$filters,paletteuse=dither=none:diff_mode=rectangle" -y GIFs/"$video.gif"
done
