.PHONY: update clean

update:
	home-manager switch --flake .#vlad

clean:
	nix-collect-garbage -d
