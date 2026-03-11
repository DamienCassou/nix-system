send-to-raspberrypi:
	rsync --archive --progress --delete ./ raspberrypi:~/personal/nix-system/

send-to-luz5:
	rsync --archive --progress --delete ./ luz5:~/personal/nix-system/
