all : image.gif video.mp4 video.webm

clean :
	rm -f image.gif
	rm -f video.mp4
	rm -f video.webm

Jellyfish_at_the_Aquarium_of_Genoa.ogv :
	wget https://upload.wikimedia.org/wikipedia/commons/9/96/Jellyfish_at_the_Aquarium_of_Genoa.ogv

image.gif : Jellyfish_at_the_Aquarium_of_Genoa.ogv
	ffmpeg -y -t 10 -i Jellyfish_at_the_Aquarium_of_Genoa.ogv -an \
		-vf scale=320:180 -vf palettegen=max_colors=32 temp-palette.png
	ffmpeg -y -t 10 -i Jellyfish_at_the_Aquarium_of_Genoa.ogv -an -i temp-palette.png \
		-filter_complex "[0:v]fps=5,scale=320:180[scout];[scout][1:v]paletteuse=dither=none" \
		image.gif

video.mp4 : Jellyfish_at_the_Aquarium_of_Genoa.ogv
	ffmpeg -y -t 10 -i Jellyfish_at_the_Aquarium_of_Genoa.ogv -an -s 320x180 -b:v 256k video.mp4

video.webm : Jellyfish_at_the_Aquarium_of_Genoa.ogv
	ffmpeg -y -t 10 -i Jellyfish_at_the_Aquarium_of_Genoa.ogv -an -s 320x180 -c:v libvpx -b:v 256k video.webm
