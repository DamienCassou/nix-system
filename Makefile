send-to-raspberrypi:
	rsync --archive --progress --delete --dry-run ./ raspberrypi:~/personal/nix-system/

send-to-luz5:
	rsync --archive --progress --delete --dry-run ./ luz5:~/personal/nix-system/
