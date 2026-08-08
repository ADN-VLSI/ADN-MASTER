.PHONY: update_all
update_all:
	@git submodule deinit -f --all
	@git pull
	@git submodule update --init
	@make -s update REPO=adn_common
	@make -s update REPO=template
	@make -s update REPO=adn_apb
	@make -s update REPO=adn_axi
	@make -s update REPO=adn_clk_rst
	@make -s update REPO=adn_endec
	@make -s update REPO=adn_uart
	@git add . && git commit -m "Update all submodules" || echo "No changes to commit"
	@git push origin main
	@clear
	@git status

.PHONY: update
update:
	@echo "Updating submodule: $(REPO)"
	@cd $(REPO) && git checkout main
	@cd $(REPO) && git reset --hard $$(git rev-list --max-parents=0 HEAD)
	@cd $(REPO) && git pull
	@cd $(REPO) && git submodule deinit -f --all
	@cd $(REPO) && git submodule update --init
	@rm -rf $(REPO)/.github
	@cp -r github $(REPO)/.github
	@mv $(REPO)/.github/Makefile $(REPO)/Makefile
	@mv $(REPO)/.github/.gitattributes $(REPO)/.gitattributes
	@cd $(REPO) && git submodule foreach 'git checkout main && git reset --hard $$(git rev-list --max-parents=0 HEAD) && git pull'
	@chmod +x $(REPO)/.github/regression.sh
	@cd $(REPO) && git add . && git commit -m "Update submodule: $(REPO)" || echo "No changes to commit"
	@cd $(REPO) && git push origin main
