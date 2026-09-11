.PHONY: update update-hm clean save

rebuild:
	git pull
	sudo nixos-rebuild switch

update: save rebuild

save:
	git add .
	git commit
	git push

update-hm:
	home-manager switch --flake .#vlad

clean:
	nix-collect-garbage -d
