.PHONY: update_all
update_all:
	@git pull
	@git submodule deinit -f .
	@git submodule update --init
	@make -s update REPO=adn_common
	@make -s update REPO=adn_apb
	@make -s update REPO=adn_axi
	@make -s update REPO=adn_endec
	@make -s update REPO=adn_uart
	@git add . && git commit -m "Update all submodules" || echo "No changes to commit"
	@git push origin main

.PHONY: update
update:
	@echo "Updating submodule: $(REPO)"
	@cd $(REPO) && git checkout main
	@cd $(REPO) && git reset --hard $$(git rev-list --max-parents=0 HEAD)
	@cd $(REPO) && git pull
	@cd $(REPO) && git submodule deinit -f .
	@cd $(REPO) && git submodule update --init
	@rm -rf $(REPO)/.github
	@cp -r github $(REPO)/.github
	@mv $(REPO)/.github/Makefile $(REPO)/Makefile
	@cd $(REPO) && git submodule foreach 'git checkout main && git reset --hard $$(git rev-list --max-parents=0 HEAD) && git pull'
	@cd $(REPO) && git add . && git commit -m "Update submodule: $(REPO)" || echo "No changes to commit"
	@cd $(REPO) && git push origin main
