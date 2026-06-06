update-raspberrypi:
	rsync --archive --progress --delete ./ raspberrypi:~/personal/nix-system/
	ssh -t raspberrypi sudo nixos-rebuild switch --flake ~/personal/nix-system/

update-luz5:
	rsync --archive --progress --delete ./ luz5:~/personal/nix-system/
	ssh -t luz5 sudo nixos-rebuild switch --flake ~/personal/nix-system/

update-pepite:
	rsync --archive --progress --delete ./ pepite:~/personal/nix-system/
	ssh -t pepite sudo nixos-rebuild switch --flake ~/personal/nix-system/

update-framework:
	rsync --archive --progress --delete ./ framework:~/.config/home-manager
	ssh -t framework 'PATH=/home/cassou/.nix-profile/bin:$PATH' home-manager switch --flake /home/cassou/.config/home-manager
