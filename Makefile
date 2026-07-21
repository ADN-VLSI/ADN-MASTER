.PHONY: update_all
update_all:
	@make -s update REPO=adn_common
	@make -s update REPO=adn_endec
	@git add . && git commit -m "Update all submodules" || echo "No changes to commit"
	@git push origin main

.PHONY: update
update:
	@echo "Updating submodule: $(REPO)"
	@cd $(REPO) && git checkout main
	@cd $(REPO) && git submodule deinit -f .
	@cd $(REPO) && git submodule update --init
	@cd $(REPO) && git submodule foreach 'git checkout main && git pull origin main'
	@cd $(REPO) && git add . && git commit -m "Update submodule: $(REPO)" || echo "No changes to commit"
	@cd $(REPO) && git push origin main
